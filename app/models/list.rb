class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, :dependent => :delete_all

  attr_accessible :title, :description, :completion_score

  validates :title, :presence => true

end
