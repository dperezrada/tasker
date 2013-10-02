class Answer
  include Mongoid::Document
  # embedded_in :task
  field :user_id, type: Moped::BSON::ObjectId
  belongs_to :task
  field :question_id, type: Moped::BSON::ObjectId
  field :answer, type: String
end
