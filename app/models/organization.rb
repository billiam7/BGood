class Organization < ApplicationRecord
  validates :api_id, presence: true, uniqueness: true
  has_and_belongs_to_many :b_good_users
end
