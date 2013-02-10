class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.text :description
      t.text :title
      t.references :task
      t.text :question
      t.references :results
      t.boolean :enabled

      t.timestamps
    end
    add_index :subtasks, :task_id
    add_index :subtasks, :results_id
  end
end
