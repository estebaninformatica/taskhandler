class Task < ActiveRecord::Base
  #attributes
  attr_accessible :description, :title, :project

  #assosiations
  belongs_to :project
  has_many :subtasks, dependent: :destroy
    
  #validations
  validates :description, :presence => true
  validates :title, :presence => true, :uniqueness => true, :length => { :maximum => 25 }
  validates :project, :presence => true
  validates_uniqueness_of :title, :scope => [:project_id]
end
