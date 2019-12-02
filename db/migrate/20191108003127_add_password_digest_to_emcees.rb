class AddPasswordDigestToEmcees < ActiveRecord::Migration[6.0]
  def change
    add_column :emcees, :password_digest, :string
  end
end
