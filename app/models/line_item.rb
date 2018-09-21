class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart

  def total_price
    product.price * quantity
  end
  def decrement_or_destroy!
    quantity > 1 ? decrement!(:quantity) : destroy!
  end
end
