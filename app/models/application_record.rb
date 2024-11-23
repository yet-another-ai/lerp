class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.from_subquery(subquery)
    from("(#{subquery.to_sql}) AS #{table_name}")
  end
end
