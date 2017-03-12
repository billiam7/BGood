class OpportunitiesController < ApplicationController
  def signup
    @opportunity = Opportunity.find_by(api_id: params['oppid'])
    if @opportunity.nil?
      @opportunity = Opportunity.create!(api_id: params['oppid'], name: params['name'], organization: params['organization'], date: params['date'], time: params['time'], link: params['link'])
    end

    @challenge = Challenge.find_or_create_by!(b_good_user: current_user, opportunity: @opportunity)

    redirect_to dashboard_path
  end
end
