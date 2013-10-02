class Task
  include Mongoid::Document
  embeds_many :questions
  has_and_belongs_to_many :users
  has_many :answers
end
