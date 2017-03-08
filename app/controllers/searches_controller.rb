require_relative './ruby_volunteer_match_client'
require_relative './miami_volunteer_match'

class SearchesController < ApplicationController
  @@miami ||= MiamiVolunteerMatch.new

  def get_initial_data
    session[:page_number] ||= 0
    opportunities = []
    opportunities.push(@@miami.opportunities)
    opportunities.flatten
  end

  def index
    # perform first search so page count is calculated
    # initialize @@miami if first time
    _opportunities = get_initial_data unless session[:page_number]
    session[:page_number] += 1

    if session[:page_number] > 1
      @@miami.get_page(session[:page_number])
      opportunities = []
      opportunities.push(@@miami.opportunities)
      _opportunities = opportunities.flatten
    end

    get_org_info = lambda do |opportunity|
      org_id = opportunity.fetch('parentOrg').fetch('id')
      fields = [
         # "id",
         # "name",
         "title",
         # "plaintextDescription",
         # "location",
         # "availability",
         # "parentOrg",
         "beneficiary",
         # "imageUrl",
         "vmUrl",
         "status",
         "tags",
         "numberOfResults",
      ]
      search_criteria = {
       "ids" => [org_id],
       "pageNumber": 1,
       "fieldsToDisplay": fields
      }
      url = VolunteerURL.new('searchOrganizations', search_criteria)
      response = APIResponse.new(url)
      key = 'organization_info'
      response_data = response.data['organizations']
      opportunity[key] = response_data
      key
    end

    convert_great_for = lambda do |opportunity|
      key = 'greatFor'
      great_for = opportunity.fetch(key)
      great_for_lookup = {
        'g' => 'groups',
        's' => 'seniors',
        'k' => 'kids',
        't' => 'teens',
      }
      great_for = great_for.map {|letter| great_for_lookup.fetch(letter) }
      opportunity[key] = great_for
      key
    end

    convert_availability = lambda do |opportunity|
      key = 'availability'
      availability = opportunity.fetch(key)
      format_keys = [
        'start date',
        'end date',
        'start time',
        'end time',
        'Is ongoing?',
        'is single day opportunity?'
      ]
      lookup = {
        nil => 'none',
        true => 'yes',
        false => 'no',
      }
      availability = [
        "startDate",
        "endDate",
        "startTime",
        "endTime",
        "ongoing",
        "singleDayOpportunity"
        ].zip(format_keys).map do |a_key, format_key|
          value = availability.fetch(a_key)
          value = lookup.fetch(value, value)
          "#{format_key}: #{value}"
        end
      opportunity[key] = availability
      key
    end

    arguments = [
      ["parentOrg", [
        "id",
        "name",
        ], [get_org_info, ], ],
      ["location", ["city", "region", "postalCode"], [], ],
      ["greatFor", [], [convert_great_for], ],
      ["availability", [
        "startDate",
        "endDate",
        "startTime",
        "endTime",
        "ongoing",
        "singleDayOpportunity"
        ], [convert_availability, ], ],
      ["minimumAge", [], [], ],
      ["plaintextDescription", [], [],],
      ["imageUrl", [], [], ],
      # ["categoryIds", [], [], ],
    ]
    @opportunities_keys = [
			'organization',
			'url',
			'location',
			'great for',
			'availability',
			'minimum age',
			'description',
			'image url',
		]
    @hidden_keys = ['image url', ]

    # start of munging
    @data_selection = _opportunities.map do |opportunity|
      arguments.map do |parent_key, child_keys, functions|
          parent_value = opportunity.fetch(parent_key)

          # execute funcs here that return a key
          modifier_keys = functions.map do |function|
            key = function.call(opportunity)  # this calls a lamda
            key
          end

          child_values = child_keys.map do |child_key|
            parent_value.fetch(child_key)
          end.map do |value|
            value.nil? ? "none" : value
          end  # replace nil values with "none" text

          # puts modifier_keys data onto child_values
          modifier_keys.each do |key|

            child_values = [
              'availability'
            ].include?(key) ? [] : child_values  # empty child values if key in list

            # add data produced from array of functions
            opportunity[key].each do |data_item|
              begin
                # p data_item
                data_item.each do |_, value| # hash
                  child_values.push(value)
                end
              rescue NoMethodError  # is an array
                child_values.push(data_item)
                # p [data_item.class, data_item, key, child_values]
              end
            end
          end
        # decode urls
        parent_value = parent_value.to_s.start_with?('http')\
          ? URI.decode_www_form_component(parent_value)\
          : parent_value
        # decode urls
        child_values = child_values.each_with_index.map do |value, i|
          # could use lambdas here to process
          value.to_s.start_with?('http') ? URI.decode_www_form_component(value) : value
        end
        child_values.empty? ? [parent_value].flatten.join(', ') : child_values.flatten.join(', ')
      end
    end.map do |opportunity|
      # split and prepend the org info
      # can't figure out how to do it above
      first = opportunity.shift
      org = first.split(', ')[1, first.size]
      org.reverse.each do |o|
        opportunity.unshift(o)
      end
      opportunity
    end.map do |opportunity| # more munging
      # modifies last item
      imgurl = opportunity.pop
      imgurl = imgurl.empty? ? imgurl : %[<img src="#{imgurl}" alt="org image">]
      opportunity.push(imgurl)

      index = @opportunities_keys.index('url')
      if index
        _string = opportunity.fetch(index)
        _string = %[<a href="#{_string}">website</a>]
        opportunity[index] = _string
      end
      opportunity
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
