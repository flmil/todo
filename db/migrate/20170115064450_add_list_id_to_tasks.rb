class AddListIdToTasks < ActiveRecord::Migration
  def change
		add_column :tasks, :list_id, :integer, default: 1
  end
end
