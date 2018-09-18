class CopyProductPriceToLineItem < ActiveRecord::Migration[5.2]
  def up
    LineItem.all.each do |li|
      li.price = li.product.price
      li.save
    end
  end
  def down
    LineItem.all.each do |li|
      li.price = nil
      li.save
    end
  end
end
