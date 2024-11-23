class ResourceInstance < ApplicationRecord
  belongs_to :resource
  has_many :rents, dependent: :destroy

  scope :availables, -> {
    from_subquery(
      select("MAX(rents.started_at), rents.returned_at, resource_instances.*")
        .from("resource_instances")
        .joins(:rents)
        .group("resource_instances.id")
        .having("rents.returned_at IS NULL"),
    )
  }
end
