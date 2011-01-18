class CreateKanbaneryIssues < ActiveRecord::Migration
  def self.up
    create_table :kanbanery_issues do |t|
      t.column :issue_id, :integer
      t.column :task_id, :integer
    end

    add_index :kanbanery_issues, :issue_id
  end

  def self.down
    drop_table :kanbanery_issues
  end
end
