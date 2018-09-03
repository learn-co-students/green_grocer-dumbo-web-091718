def consolidate_cart(cart)
    # code here
new_cart = Hash.new

  cart.each do |item|
    item.each do |name, details| item 
       if new_cart.include?(name)  # if it has an item a
          new_cart[name][:count] += 1
       else # else if not, add a new hash in the details
          new_cart[name] = Hash.new
          details.each do |key, val|
          new_cart[name][key] = val
        end 
          new_cart[name][:count] = 1
      end 
    end 
  end 

  new_cart
end 
# p consolidate(cart)

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    item = coupon_hash[:item]

    if !cart[item].nil? && cart[item][:count] >= coupon_hash[:num]
      new_coupon_hash = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => cart[item][:clearance],
        :count => 1
        }
      }
      
      if cart["#{item} W/COUPON"].nil?
        cart.merge!(new_coupon_hash)
      else
        cart["#{item} W/COUPON"][:count] += 1
      end
      
      cart[item][:count] -= coupon_hash[:num]
    end
  end
  cart
end

def apply_clearance(cart)
    cart.each do |item, item_info|
    if item_info[:clearance]
      item_info[:price] = (item_info[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
    process_total = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
    total = 0.0;
   process_total.each do |item_name, item_info|
    total += item_info[:count] * item_info[:price]
  end
  total > 100 ? (0.9 * total).round(2) : total

end
