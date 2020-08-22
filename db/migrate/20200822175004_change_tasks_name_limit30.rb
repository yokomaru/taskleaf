class ChangeTasksNameLimit30 < ActiveRecord::Migration[6.0]
  def change
    def up
      change_column :tasks, :name, :string, limit: 30
    end

    def down
      change_column :tasks, :name
    end
  end
end
