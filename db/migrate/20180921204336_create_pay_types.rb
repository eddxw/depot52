class CreatePayTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_types do |t|
      t.string :title

      t.timestamps
    end
    populate_pay_types
  end

  protected

  def populate_pay_types
    PayType.create(title: 'Check')
    PayType.create(title: 'Credit card')
    PayType.create(title: 'Purchase order')
  end
end
