class AddPayTypeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :pay_type, foreign_key: true
  end
end
