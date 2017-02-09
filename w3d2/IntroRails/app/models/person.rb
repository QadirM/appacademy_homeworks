class Person < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :house_id, presence: true
end
