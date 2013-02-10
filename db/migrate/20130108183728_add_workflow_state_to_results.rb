class AddWorkflowStateToResults < ActiveRecord::Migration
  def change
    add_column :results, :workflow_state, :string
  end
end
