def consolidate_cart(cart)
  # code here

  cart.each_with_object({}) do |item, attributes|
    item.each do |k, v|
      if attributes[k]
        v[:count] += 1
      else
        v[:count] = 1
        attributes[k] = v
      end
    end
  end
end

require "pry"
def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {
          :count => 1,
          :price => coupon[:cost]
        }
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
    end
    cart[name][:count] -= coupon[:num]
  end
end
return cart
end

def apply_clearance(cart)
  # code here
  discount_cart = {}

  cart.each do |item, attributes|
    if attributes[:clearance] == true
      discount = attributes[:price]/10
      discount += discount
      attributes[:price] -= discount
      discount_cart[item] = attributes
    else
      discount_cart[item] = attributes
    end
  end
end

def checkout(cart, coupons)
  # code here
  total_checkout = 0
  #
  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)

  clearance_applied.each do |key, value|
    total_checkout += value[:price] * value[:count]
  end

  total_checkout = total_checkout * 0.9 if total_checkout > 100
  return total_checkout
end
