def consolidate_cart(cart)
  hash = {}

  cart.each do |item|
    item.each do |name, info|
      if hash.include?(name)
        hash[name][:count] += 1
      else
        hash[name] = info
        hash[name][:count] = 1
      end
    end
  end

  hash
end

def apply_coupons(cart, coupons)
  hash = {}
  
  cart.each do |item, info|
    coupons.each do |couponed_item|
      if item == couponed_item[:item] && couponed_item[:num] <= info[:count]
        cart[item][:count] -= couponed_item[:num] 
        if hash["#{item} W/COUPON"]
          hash["#{item} W/COUPON"][:count] += 1
        else
          hash["#{item} W/COUPON"] = {
            price:     couponed_item[:cost],
            clearance: info[:clearance],
            count:     1,
          }
        end
      end
    end
    hash[item] = info
  end

  hash
end

def apply_clearance(cart)
  hash = {}
  cart.each do |item, info|
    if info[:clearance]
      discount = info[:price] - info[:price] * 0.20
      info[:price] = discount 
      hash[item] = info
    else
      hash[item] = info
    end
  end

  hash
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart     = apply_coupons(consolidated_cart, coupons)
  new_cart          = apply_clearance(couponed_cart)
  total = 0
  new_cart.each { |k, v| total += v[:price] * v[:count] }
  total = total * 0.9 if total > 100
  total
end