require_relative 'ruby_volunteer_match_client'

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



# begin
#   file = File.open("opportunities.json", "w")
#   file.write(data_selection.to_json)
# rescue IOError => e
#   puts e
# ensure
#   file.close unless file.nil?
# end

# p data_selection.sample
