class SearchesController < ApplicationController
  def index
    @opportunities = MiamiVolunteerMatch.new.opportunities
  end
end
