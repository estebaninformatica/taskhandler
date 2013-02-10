class Project < ActiveRecord::Base
  attr_accessible :description, :title, :tasks
  has_many :tasks, dependent: :destroy
	
	#validations
  validates :description, :presence => true 
  validates :title, :presence => true, :uniqueness => true, :length => { :maximum => 40 }

end
