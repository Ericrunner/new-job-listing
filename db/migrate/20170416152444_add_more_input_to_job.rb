class AddMoreInputToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs,:wage_upper_bound,:integer
    add_column :jobs,:wage_down_bound,:integer
    add_column :jobs,:contact_email,:string
    add_column :jobs,:is_hidden,:boolean
  end
end
