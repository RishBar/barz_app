class AddActivationToEmcees < ActiveRecord::Migration[6.0]
  def change
    add_column :emcees, :activation_digest, :string
    add_column :emcees, :activated, :boolean
    add_column :emcees, :activated_at, :datetime
  end
end
