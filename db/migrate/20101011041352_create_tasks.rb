class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :priority
      t.text :description
      t.decimal :estimated_hrs, :precision => 8, :scale => 4
      t.datetime :completed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
