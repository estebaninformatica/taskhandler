class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :subtask
      t.references :user
      t.integer :question_score
      t.text :comment
      t.datetime :time_begin
      t.datetime :time_end
      t.datetime :time_break

      t.timestamps
    end
    add_index :results, :subtask_id
    add_index :results, :user_id
  end
end
