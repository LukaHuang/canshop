module Account::ProductsHelper
  def total(products)
    total = 0
    products.each do |product|
      total += product.price * product.amount
    end
    total
  end
end
