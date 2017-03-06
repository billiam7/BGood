
require_relative 'volunteer_match_client'

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

end

# miami = MiamiVolunteerMatch.new
#
# # perform first search so page count is calculated
# opportunities = []
# opportunities.push(miami.opportunities)
# count = miami.page_count
#
# count.times do
#   miami.next_page
#   opportunities.push(miami.opportunities)
# end
#
#
# _opportunities = opportunities.flatten
# opportunities_keys = _opportunities.first.keys
# data = {opportunities: _opportunities, keys: opportunities_keys}
#
# get_org_info = lambda do |opportunity|
#   org_id = opportunity.fetch('parentOrg').fetch('id')
#   fields = [
#      # "id",
#      # "name",
#      "title",
#      # "plaintextDescription",
#      # "location",
#      # "availability",
#      # "parentOrg",
#      "beneficiary",
#      # "imageUrl",
#      "vmUrl",
#      "status",
#      "tags",
#      "numberOfResults",
#   ]
#   search_criteria = {
#    "ids" => [org_id],
#    "pageNumber": 1,
#    "fieldsToDisplay": fields
#   }
#   url = VolunteerURL.new('searchOrganizations', search_criteria)
#   response = APIResponse.new(url)
#   key = 'organization_info'
#   opportunity[key] = response.data['organizations']  # array
#   key
# end
#
# convert_great_for = lambda do |opportunity|
#   key = 'greatFor'
#   great_for = opportunity.fetch(key)
#   great_for_lookup = {
#     'g' => 'groups',
#     's' => 'seniors',
#     'k' => 'kids',
#     't' => 'teens',
#   }
#   great_for = great_for.map {|letter| great_for_lookup.fetch(letter) }
#   opportunity[key] = great_for
#   key
# end
#
# convert_availability = lambda do |opportunity|
#   key = 'availability'
#   availability = opportunity.fetch(key)
#   availability = [
#     "startDate",
#     "endDate",
#     "startTime",
#     "endTime",
#     "ongoing",
#     "singleDayOpportunity"
#     ].map do |a_key|
#       value = availability.fetch(a_key)
#       value = value.nil? ? "none" : value
#       "#{a_key}: #{value}"
#     end
#   opportunity[key] = availability
#   key
# end
#
# identity = lambda do |opportunity|  # for testing
#   'greatFor'
# end
#
# arguments = [
#   ["parentOrg", [
#     "id",
#     "name",
#     ], [get_org_info, ], ],
#   ["location", ["city", "region", "postalCode"], [], ],
#   ["greatFor", [], [convert_great_for], ],
#   ["availability", [
#     "startDate",
#     "endDate",
#     "startTime",
#     "endTime",
#     "ongoing",
#     "singleDayOpportunity"
#     ], [convert_availability, ], ],
#   ["minimumAge", [], [], ],
#   ["plaintextDescription", [], [],],
#   ["imageUrl", [], [], ],
#   # ["categoryIds", [], [], ],
# ]
#
# miami.data
#
# data_selection = _opportunities.map do |opportunity|
#   arguments.map do |parent_key, child_keys, functions|
#       parent_value = opportunity.fetch(parent_key)
#       # execute funcs here that return a key
#       modifier_keys = functions.map do |function|
#         key = function.call(opportunity)  # this calls a lamda
#         key
#       end
#
#       child_values = child_keys.map do |child_key|
#         parent_value.fetch(child_key)
#       end.map do |value|
#         value.nil? ? "none" : value
#       end  # replace nil values with "none" text
#
#       # puts modifier_keys data onto child_values
#       modifier_keys.each do |key|
#
#         child_values = [
#           'availability'
#           ].include?(key) ? [] : child_values  # empty child values if key in list
#
#         # add data produced from array of functions
#         opportunity[key].each do |data_item|
#           begin
#             data_item.each do |_, value| # hash
#               child_values.push(value)
#             end
#           rescue NoMethodError  # is an array
#             child_values.push(data_item)
#             # p [data_item.class, data_item, key, child_values]
#           end
#         end
#       end
#     # decode urls
#     parent_value = parent_value.to_s.start_with?('http')\
#       ? URI.decode_www_form_component(parent_value)\
#       : parent_value
#     # decode urls
#     child_values = child_values.each_with_index.map do |value, i|
#       # could use lambdas here to process
#       value.to_s.start_with?('http') ? URI.decode_www_form_component(value) : value
#     end
#     child_values.empty? ? [parent_value].flatten.join(', ') : child_values.flatten.join(', ')
#   end
# end
#
# begin
#   file = File.open("opportunities.json", "w")
#   file.write(data_selection.to_json)
# rescue IOError => e
#   puts e
# ensure
#   file.close unless file.nil?
# end
#
# p data_selection.sample
