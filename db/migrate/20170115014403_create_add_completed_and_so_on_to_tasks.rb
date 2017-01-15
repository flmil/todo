class CreateAddCompletedAndSoOnToTasks < ActiveRecord::Migration
  def change
		add_column :tasks, :completed, :boolean
		add_column :tasks, :due_date, :date
		add_column :tasks, :star, :boolean
  end
end
