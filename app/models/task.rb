class Task < ActiveRecord::Base
  belongs_to :list

  after_save :update_list_completion

  scope :completed, where(:done => true).order('due_date ASC')
  scope :uncompleted, where(:done => false).order('due_date ASC')

  attr_accessible  :title, :description, :due_date, :done

  validates_presence_of :title
  validates :due_date, :future_date => true, :on => :create


  private

  # Updates parent list completion score
  def update_list_completion
  	list_tasks = self.list.tasks
    number_tasks = list_tasks.size
    completed_tasks = list_tasks.completed.size
    self.list.update_attributes(:completion_score => ((completed_tasks.to_f/number_tasks.to_f) * 100).to_i )
  end
end