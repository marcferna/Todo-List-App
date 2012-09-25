class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :list_id
      t.string :title
      t.text :description
      t.date :due_date
      t.boolean :done, :default => false

      t.timestamps
    end
  end
end
