class AddResetToEmcees < ActiveRecord::Migration[6.0]
  def change
    add_column :emcees, :reset_digest, :string
    add_column :emcees, :reset_sent_at, :datetime
  end
end
