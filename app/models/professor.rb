class Professor < ActiveRecord::Base
  has_many :comments
  acts_as_taggable 
  acts_as_taggable_on :courses
  validates_length_of :description, :maximum => 700
end
