class Subtask < ActiveRecord::Base
  belongs_to :task
  has_many :results, dependent: :destroy
  attr_accessible :description, :enabled, :question, :title ,:task, :results, :type_question
  #validations
  validates :description, :presence => true
  validates :question, :presence => true
  validates :title, :presence => true, :uniqueness => true, :length => { :maximum => 40 }
  validates :task, :presence => true
  validates :type_question, :presence => true

  def my_result(current_user)
  	return nil if self.results.nil?
  	return (self.results.where(:user_id => current_user).first)
  end

  def all_type_questions
    return [["question","question"  ],["all","all"],["select_number","select_number"]]
  end
end
