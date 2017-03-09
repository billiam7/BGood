class Organization < ApplicationRecord
  validates :api_id, presence: true, uniqueness: true
end
