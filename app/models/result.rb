class Result < ActiveRecord::Base
  belongs_to :subtask
  belongs_to :user
  attr_accessible :comment, :question_score, :user, :time_begin, :time_end,:time_break,:user_id,:workflow_state
  validates :user_id, :presence => true 
  validates_uniqueness_of :user_id, :scope => [:user_id, :subtask_id]
  validates :comment, presence: true, on: :update,  if: :subtask_question_coment?
  validates :question_score, presence: true, on: :update, if: :subtask_question_select_number?
  validates :comment, presence: true, on: :update, if: :subtask_comment_all?

  def initialize(current_user)
    super(user:current_user, time_begin:Time.now)
  end
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
    csv << column_names
    all.each do |result|
      csv << result.attributes.values_at(*column_names)
    end
    end
  end

  def time_difference
    if self.time_end.nil?
      self.time_end = time_break
    end 
    Time.diff(self.time_end,self.time_begin)[:diff]
  end

  def event_complete
    self.time_end = Time.now
  end

  def event_pause
    self.time_break = Time.now
  end

  def event_start
    self.time_begin = Time.now - ( self.time_break - self.time_begin)
  end

  def workflow_state_finish
    workflow_state == "finish" 
  end

  def subtask_question_coment?
    workflow_state_finish && self.subtask.type_question == "comment"
  end

  def subtask_question_select_number?
    workflow_state_finish && self.subtask.type_question == "select_number"
  end

  def subtask_comment_all?
    workflow_state_finish && self.subtask.type_question == "all"
  end
  include Workflow
  workflow do
    state :begin do
      event :event_pause, :transitions_to => :pause
      event :event_complete, :transitions_to => :complete
    end
    state :pause do
      event :event_start, :transitions_to => :begin
    end
    state :complete do
      event :event_finish, :transitions_to => :finish
    end
    state :finish do
      event :event_edit, :transitions_to => :complete
      event :event_finish, :transitions_to => :finish
    end
  end
end
