require_relative 'volunteer_match_client'

module ActionKeys
  @@lookup = {
    "getKeyStatus" => [
      'methods', 
      'owner', 
      'apiKeyConstraints'
    ],
    "getServiceStatus" => [
      "publicMembers", 
      "publicOpportunities", 
      "publicOrganizations", 
      "publicOrganizationsWithOpportunities", 
      "publicReferrals", 
      "timestamp", 
      "uptime"
    ],
    "getMetaData" => [
      "categories", 
      "grantFields", 
      "greatFor", 
      "hoursTrackingEmployeeEnteredOppFields", 
      "hoursTrackingEmployeeEnteredOrgFields", 
      "hoursTrackingFields", 
      "memberFields", 
      "opportunityTypes", 
      "partners", 
      "passwordRules", 
      "radii", 
      "referralFields", 
      "requiresRegistrationAddress",
      "standardRegistrationFields", 
      "usCorps", 
      "useHoursIncrements", 
      "version"
    ],
    "helloWorld" => [
      "name",
      "result",
    ],
    "searchOrganizations" => [
      "currentPage", 
      "organizations", 
      "resultsSize"
    ],
    "searchOpportunities" => [
      "currentPage", 
      "opportunities", 
      "resultsSize", 
      "sortCriteria"
    ],
  }
  
  def self.action_keys
    @@lookup
  end
end

class MiamiVolunteerMatch
  include ActionKeys
  
  attr_accessor :query_params, 
  :action,
  :url,
  :data, 
  :current_page, 
  :opportunities, 
  :results_size, 
  :sort_criteria,
  :page_count
  
  def initialize
    @query_params = {location: "miami, fl", pageNumber: 1 }
    @action = 'searchOpportunities'
    self.call
    @page_count = (@results_size / @opportunities.size)
  end
  
  def call
    url = VolunteerURL.new(@action, @query_params)
    response = APIResponse.new(url)
    @data = response.data
    @current_page, 
    @opportunities, 
    @results_size, 
    @sort_criteria = ActionKeys.action_keys.fetch(@action).map do |key|
      @data.fetch(key)
    end
    
  end
  
  def next_page
    _next_page = @current_page + 1
    @query_params = {location: @query_params.fetch(:location), pageNumber: _next_page}
    self.call
  end

  def get_page(page)
    @query_params = {location: @query_params.fetch(:location), pageNumber: page}
    self.call
  end
end

