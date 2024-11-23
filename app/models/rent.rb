class Rent < ApplicationRecord
  belongs_to :resource_instance
  belongs_to :user
end
