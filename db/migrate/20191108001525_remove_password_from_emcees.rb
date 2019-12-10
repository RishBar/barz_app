# frozen_string_literal: true

class RemovePasswordFromEmcees < ActiveRecord::Migration[6.0]
  def change
    remove_column :emcees, :password
  end
end
