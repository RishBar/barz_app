class AddRememberDigestToEmcees < ActiveRecord::Migration[6.0]
  def change
    add_column :emcees, :remember_digest, :string
  end
end
