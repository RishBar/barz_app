# frozen_string_literal: true

class AddPasswordConfirmationToEmcees < ActiveRecord::Migration[6.0]
  def change
    add_column :emcees, :password_confirmation, :string
  end
end
