# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :source
      t.string :native_language
      t.text   :target_language
      t.string :country

      t.timestamps
    end
  end
end
