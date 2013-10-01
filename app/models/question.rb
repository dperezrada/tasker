class Question
  include Mongoid::Document
  embedded_in :task
  field :question, type: String
  has_many :answers
end
