class AddHiredColumnToProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :hired, :boolean, default: false
  end
end
