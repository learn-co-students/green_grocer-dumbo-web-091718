def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |item|
    item.each do |name, value|
      if cart_hash[name]
        cart_hash[name][:count] += 1 
      else 
        cart_hash[name] = value
        cart_hash[name][:count] = 1 
      end 
    end 
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupon_cart = {}
  cart.each do |item, info|
    coupons.each do |coupon|
      if item == coupon[:item] && info[:count] >= coupon[:num]
        cart[item][:count] = cart[item][:count] - coupon[:num]
        if coupon_cart[item + " W/COUPON"]
          coupon_cart[item + " W/COUPON"][:count] += 1
        else 
          coupon_cart[item + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item][:clearance], :count => 1}
        end 
      end 
    end 
    coupon_cart[item] = info
  end
  coupon_cart
end

def apply_clearance(cart)
  # code here
  clearance_cart = {}
  cart.each do |item, info|
    clearance_cart[item] = {}
    info.each do |key|
    if cart[item][:clearance] == true
      clearance_cart[item][:price] = (cart[item][:price] * 0.80).round(2)
    else 
      clearance_cart[item][:price] = cart[item][:price]
    end 
    clearance_cart[item][:clearance] = cart[item][:clearance]
    clearance_cart[item][:count] = cart[item][:count]
  end 
end
  clearance_cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  total = 0 
  
  clearance_cart.each do |item, info|
    total += info[:price] * info[:count]
  end 
  if total > 100
    total *= (0.90)
  end
    total 
end
