# frozen_string_literal: true

class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      # must have
      t.string :type, null: false # STI class
      t.string :name, null: false
      t.string :description, null: false, default: ""

      # books only
      t.string :isbn, null: true

      t.timestamps
    end

    # Resource might have multiple instances
    create_table :resource_instances do |t|
      t.references :resource, null: false, foreign_key: true
      t.string :comment, null: false, default: ""

      t.datetime :deleted_at, null: true
      t.string :deleted_for, null: false, default: ""
      t.timestamps

      t.index [:resource_id, :deleted_at]
    end

    create_table :rents do |t|
      t.string :comment, null: false, default: ""

      t.references :resource_instance, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.datetime :started_at, null: false
      t.datetime :expired_at, null: false
      t.datetime :returned_at, null: true

      t.timestamps
    end
  end
end
