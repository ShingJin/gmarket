class Professor < ActiveRecord::Base
  has_many :comments
end
