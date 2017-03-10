class BGoodUser < ApplicationRecord
  has_many :challenges
  has_and_belongs_to_many :organizations

  # has_and_belongs_to_many :b_good_users,
  #             class_name: "BGoodUser",
  #             join_table: :challenges,
  #             foreign_key: :b_good_user_id,
  #             association_foreign_key: :challenger_b_good_user_id
end
