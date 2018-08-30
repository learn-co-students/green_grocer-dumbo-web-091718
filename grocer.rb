def consolidate_cart(cart)
  new_cart = {}
  counter = []
    
  cart.each do |ele|
    ele.keys.each do |ele1|
      counter << {ele1 => 1}
      ele[ele1][:count] = 0
      new_cart = cart.reduce Hash.new, :merge 
    end
  end

  counter.each do |ele1|
    new_cart.each do |key, val|
      if ele1[key] != nil
        new_cart[key][:count] += 1
      end
    end
  end

  return new_cart
end

def consolidate_coups(coup)
  counter = {}
  coup.each do |ele|
    food_item = ele[:item]
    counter[food_item] = 0 
  end
  counter.each do |k, v|
    coup.each do |k1|
       if k1[:item] == k
        counter[k] += 1
      end
    end
  end
  return counter
end

def apply_coupons(cart, coupons)
  coup_hash = consolidate_coups(coupons)
  coupons.each do |coups|
    food = coups[:item]
    cart.keys.each do |thing|
      if food == thing 
        sum = coup_hash[food]
        clear = cart[food][:clearance]
        money = coups[:cost]
        cart_count = cart[food][:count] 
        coups_total = coups[:num]
        coups_used = (cart_count/coups_total).floor
        cart["#{food} W/COUPON"] = {:price => money, :clearance => clear, :count => coups_used}
      end 
    end
  end
  coup_hash.each do |c, v|
    cart.each do |food, val|
      coupons.each do |ele|
        if c == food && c == ele[:item]
          if cart[food][:count] >= (v*ele[:num])
            cart[food][:count] = cart[food][:count] % (v*ele[:num])
          elsif cart[food][:count] < (v*ele[:num])
            cart[food][:count] = cart[food][:count] % ele[:num]
          end
        end
      end
    end
  end
  return cart
end


def apply_clearance(cart)
  cart.each do |k, v|
    if cart[k][:clearance] == true
      discounted = cart[k][:price]*0.80
      cart[k][:price] = discounted.round(2) 
    end
  end
  return cart
end

def checkout(cart, coupons)
  step1 = consolidate_cart(cart)
  step2 = apply_coupons(step1, coupons)
  step3 = apply_clearance(step2)
  sum = 0 
  step3.each do |ele, k|
    sum +=  (k[:price]*k[:count])
  end
  if sum > 100 
    total = (sum * 0.9).round(2) 
  else
    total = sum
  end
  return total 
end
