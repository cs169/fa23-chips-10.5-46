class AddDetailsToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :address, :array
    add_column :representatives, :photo, :string
    add_column :representatives, :party, :string
  end
end