class Opportunity < ApplicationRecord
  has_many :challenges, dependent: :destroy
end
