# module ActionKeys
#   @@lookup = {
#     "getKeyStatus" => [
#       'methods',
#       'owner',
#       'apiKeyConstraints'
#     ],
#     "getServiceStatus" => [
#       "publicMembers",
#       "publicOpportunities",
#       "publicOrganizations",
#       "publicOrganizationsWithOpportunities",
#       "publicReferrals",
#       "timestamp",
#       "uptime"
#     ],
#     "getMetaData" => [
#       "categories",
#       "grantFields",
#       "greatFor",
#       "hoursTrackingEmployeeEnteredOppFields",
#       "hoursTrackingEmployeeEnteredOrgFields",
#       "hoursTrackingFields",
#       "memberFields",
#       "opportunityTypes",
#       "partners",
#       "passwordRules",
#       "radii",
#       "referralFields",
#       "requiresRegistrationAddress",
#       "standardRegistrationFields",
#       "usCorps",
#       "useHoursIncrements",
#       "version"
#     ],
#     "helloWorld" => [
#       "name",
#       "result",
#     ],
#     "searchOrganizations" => [
#       "currentPage",
#       "organizations",
#       "resultsSize"
#     ],
#     "searchOpportunities" => [
#       "currentPage",
#       "opportunities",
#       "resultsSize",
#       "sortCriteria"
#     ],
#   }
#
#   def self.action_keys
#     @@lookup
#   end
# end

class MiamiVolunteerMatch
  # include ActionKeys

  # attr_accessor :query_params,
  #   :action,
  #   :url,
  #   :data,
  #   :current_page,
  #   :opportunities,
  #   :results_size,
  #   :sort_criteria,
  #   :page_count
  attr_accessor :query_params, :results_size, :opportunities

  def initialize
    @query_params = {location: "miami, fl", pageNumber: 1 }
    @action = 'searchOpportunities'
    self.call
    @page_count = (@results_size / @opportunities.size)
  end

  def call
    url = VolunteerMatchClient::VolunteerURL.new(@action, @query_params)
    response = VolunteerMatchClient::APIResponse.new(url)
    @data = response.data

    @opportunities = @data['opportunities']
    cleanUrls(@opportunities)

    @results_size = @data['resultsSize']
    # @current_page,
    # @opportunities,
    # @results_size,
    # @sort_criteria = ActionKeys.action_keys.fetch(@action).map do |key|
    #   @data.fetch(key)
    # end
  end

  def get_page(page)
    @query_params = {location: @query_params.fetch(:location), pageNumber: page}
    self.call
  end

  def cleanUrls(opportunities)
    opportunities.each do |opportunity|
      %w[vmUrl imageUrl].each do |field|
        url = opportunity[field]
        opportunity[field] = CGI::unescape(url) if url
      end
    end
  end
end
