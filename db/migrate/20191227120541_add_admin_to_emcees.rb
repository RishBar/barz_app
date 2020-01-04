class AddAdminToEmcees < ActiveRecord::Migration[6.0]
  def change
    add_column :emcees, :admin, :boolean
  end
end
