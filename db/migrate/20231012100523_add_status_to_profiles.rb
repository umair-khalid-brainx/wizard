class AddStatusToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :status, :string
    add_column :profiles, :next_step, :string
  end
end
