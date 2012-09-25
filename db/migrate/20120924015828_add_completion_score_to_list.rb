class AddCompletionScoreToList < ActiveRecord::Migration
  def change
    add_column :lists, :completion_score, :integer, :default => 0
  end
end
