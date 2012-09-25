class User < ActiveRecord::Base
  has_many :lists

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  def overdue_tasks
    @tasks = Task.where("done = false AND due_date < ?", Date.today)
      .joins(:list)
      .where(:lists => {:user_id => self})
  end
end
