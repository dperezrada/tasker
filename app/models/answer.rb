class Answer
  include Mongoid::Document
  # embedded_in :task
  field :user_id, type: Moped::BSON::ObjectId
  # belongs_to :question
  field :question_id, type: Moped::BSON::ObjectId
  field :answer, type: String
end
