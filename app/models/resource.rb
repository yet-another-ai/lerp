class Resource < ApplicationRecord
  has_many :resource_instances, dependent: :destroy
end
