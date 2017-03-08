
require 'base64'
require 'digest/sha2'
require 'uri'
require 'json'
require 'httparty'


class Credentials
  attr_reader = :account_name, :api_key
  
  def initialize
    env_keys = ['ACCOUNTNAME', 'APIKEY']
    begin
      @account_name, 
      @api_key = env_keys.map {|attr| ENV.fetch(attr)}
    rescue KeyError
      account_name, api_key = env_keys
      message = [
        %[ENV is used to get the account name and ],
        %[api key values.\n],
        %[Set environment variables '#{account_name}' and '#{api_key}' ],
        %[to the appropriate values before using this module.\n],
      ].join
      raise NameError.new message
    end
  end
  
  def credentials
    [@account_name, @api_key]
  end
end

module Authentication
  @@nonce,
  @@creation_time,
  @@password_digest = 3.times.map {nil}
  @@credentials = Credentials.new
  @@account_name, @@api_key = @@credentials.credentials
  
  
  def self.set_nonce
    @@nonce = Digest::SHA2.hexdigest(rand.to_s)
  end
  
  def self.set_creation_time
    @@creation_time = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
  end
  
  def self.set_password_digest
    self.set_nonce
    self.set_creation_time
    
    @@password_digest = Base64.encode64(
      Digest::SHA2.digest(
        [
          @@nonce,
          @@creation_time,
          @@api_key
        ].join
      )
    ).chomp
  end
  
  def self.wsse
    self.set_password_digest
    [
      %[UsernameToken Username="#{@@account_name}"],
      %[PasswordDigest="#{@@password_digest}"],
      %[Nonce="#{@@nonce}"],
      %[Created="#{@@creation_time}"],
    ].join(', ')
  end
end

class VolunteerURL
  attr_reader :url, :actions
  @@actions = [
    "helloWorld",
    "getKeyStatus", 
    "getServiceStatus",
    "getMetaData",
    "searchOrganizations",
    "searchOpportunities",
  ]
  
  def self.actions
    @@actions
  end
  
  def initialize(action, action_params)
    action_params_json = action_params.to_json
    @url = URI.parse([
      'http://',
      'www.volunteermatch.org',
      '/api/call',
      '?',
      URI.encode_www_form({action: action, query: action_params_json}),
    ].join)
  end
end

class APIResponse
  attr_reader :response
  include Authentication
  
  def initialize(volunteer_url)
    @response = HTTParty.get(volunteer_url.url, 
      headers: {
                'Content-Type' => 'application/json',
                'Authorization' => 'WSSE profile="UsernameToken"',
                'X-WSSE' => Authentication.wsse
               }
    )
  end
  
  def data
    @response.parsed_response
  end
end
