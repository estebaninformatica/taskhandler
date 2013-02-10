class AddTypeQuestionToSubtasks < ActiveRecord::Migration
  def change
    add_column :subtasks, :type_question, :string
  end
end
