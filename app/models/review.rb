class Review < ActiveRecord::Base
  belongs_to :place
  attr_accessible :body, :reviewer
  validates :reviewer, :body, presence: true
end
