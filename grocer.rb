def consolidate_cart(cart)
  cart_hash = {}
  num = 1

  cart.each do |item|
    item.each do |food, food_detail|

      if cart_hash.keys.include?(food)
        num += 1
        cart_hash[food][:count] = num
      else
        cart_hash[food] = food_detail
        cart_hash[food][:count] = 1
      end

    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)

  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num] #minimum amt of items

      new_key = "#{coupon[:item]} W/COUPON"
      cart[coupon[:item]][:count] -= coupon[:num] #changes original cart count

      if cart.keys.include?(new_key) #for multiple coupons of the same grocery
        cart[new_key][:count] += 1
      else
        cart[new_key] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
      end
    end
  end

  cart
end

def apply_clearance(cart)

  cart.each do |food, data|
    if data[:clearance] == true
      discounted_price = data[:price] * 0.8
      data[:price] = discounted_price.round(1)
    end
  end
  cart

end

def checkout(cart, coupons)

  consolidated_cart = consolidate_cart(cart)
  cart_coupons = apply_coupons(consolidated_cart, coupons)
  cart_clearance = apply_clearance(cart_coupons)

  new_total = 0
  cart_clearance.each do |grocery, details|
    new_total += details[:price] * details[:count]
  end

  if new_total > 100
    new_total = (new_total * 0.9).round(2)
  end

  new_total

  end
