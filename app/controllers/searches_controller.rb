class SearchesController < ApplicationController
  def index
   # client = Volunteermatch::Client.new('BGood', '083591354ab35892642e4a6b6a02caed')
   client = Volunteermatch::Client.new(ENV["VMACCOUNTNAME"], ENV["VMAPIKEY"])
   if params[:term]
     @results = client.search_opportunities(location: "Miami, FL",
                                           fieldsToDisplay: ["name", "title", "plaintextDescription", "numberOfResults", "location"],
                                           keywords: [params[:term]],
                                           sortCriteria: "eventdate"
                                           )
   else
     @results = client.search_opportunities(location: "miami, FL",
                                           opportunityTypes:["public","private"],
                                           fieldsToDisplay:["title",
                                           "location", "parentOrg", "plaintextDescription",  "volunteersNeeded", "spacesAvailable",  "requiresAddress", "referralFields",
                                           "imageUrl",  "tags", "vmUrl"]
                                           )
     end
 end
end
