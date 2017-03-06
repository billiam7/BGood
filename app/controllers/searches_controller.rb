require_relative './volunteer_match_client'
require_relative './miami_volunteer_match'

class SearchesController < ApplicationController
  def index
    miami = MiamiVolunteerMatch.new
    opportunities = []
    opportunities.push(miami.opportunities)
    @count = miami.page_count 
    

  end
end

# title
# availability
# parentOrg
# beneficiary
# plaintextDescription
# imageUrl
# vmUrl
# status
# tags
