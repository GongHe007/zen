class AddCertificationToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :certification, :boolean, null: false, default: false
  end
end
