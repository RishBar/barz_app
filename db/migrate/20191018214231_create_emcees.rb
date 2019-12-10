# frozen_string_literal: true

class CreateEmcees < ActiveRecord::Migration[6.0]
  def change
    create_table :emcees do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
