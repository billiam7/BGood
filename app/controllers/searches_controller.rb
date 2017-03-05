class SearchesController < ApplicationController
  def index

   client = Volunteermatch::Client.new(ENV.fetch("VMACCOUNTNAME"), ENV.fetch("VMAPIKEY"))
   if params[:term]
     @results = client.search_opportunities(location: "Miami, FL",
                                           fieldsToDisplay: ["name", "title", "plaintextDescription","location", "availability", "parentOrg", "beneficiary", "imageUrl", "vmUrl", "status", "tags", "numberOfResults"],
                                           keywords: [params[:term]],
                                           sortCriteria: "update"
                                           )
   else
     @results = client.search_opportunities(location: "Miami, FL",
                                           fieldsToDisplay: ["name", "title", "plaintextDescription","location", "availability", "parentOrg", "beneficiary", "imageUrl", "vmUrl", "status", "tags", "numberOfResults"],
                                           sortCriteria: "update"
                                           )

    end
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
