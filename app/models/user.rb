class User < ApplicationRecord
  has_many :challenges
  has_and_belongs_to_many :users,
              class_name: "User",
              join_table: :challenges, 
              foreign_key: :user_id,
              association_foreign_key: :challenger_user_id
end
