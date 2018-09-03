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

# Other attemps ______________
# def consolidate_cart(cart)
#   hash = {}
#   cart.each do |item_hash|
#     item_hash.each do |name, price_hash|
#       if hash[name].nil?
#         hash[name] = price_hash.merge({:count => 1})
#       else
#         hash[name][:count] += 1
#       end
#     end
#   end
#   hash
# end

# def apply_coupons(cart, coupons)
#   hash = cart
#   coupons.each do |coupon_hash|
#     # add coupon to cart
#     item = coupon_hash[:item]

#     if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
#       temp = {"#{item} W/COUPON" => {
#         :price => coupon_hash[:cost],
#         :clearance => hash[item][:clearance],
#         :count => 1
#         }
#       }
      
#       if hash["#{item} W/COUPON"].nil?
#         hash.merge!(temp)
#       else
#         hash["#{item} W/COUPON"][:count] += 1
#         #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
#       end
      
#       hash[item][:count] -= coupon_hash[:num]
#     end
#   end
#   hash
# end

# def apply_clearance(cart)
#   cart.each do |item, price_hash|
#     if price_hash[:clearance] == true
#       price_hash[:price] = (price_hash[:price] * 0.8).round(2)
#     end
#   end
#   cart
# end

# def checkout(items, coupons)
#   cart = consolidate_cart(items)
#   cart1 = apply_coupons(cart, coupons)
#   cart2 = apply_clearance(cart1)
  
#   total = 0
  
#   cart2.each do |name, price_hash|
#     total += price_hash[:price] * price_hash[:count]
#   end
  
#   total > 100 ? total * 0.9 : total
  
# end


#  ******* ----------- LA Solu
# def consolidate_cart(cart)
#   result = Hash.new

#   cart.each do |item|
#     item.each do |item_name, item_data|
#       # If the item is not added to consolidated cart
#       if result.include?(item_name)
#         result[item_name][:count] += 1
#       else # If item is added to consolidated cart
#         result[item_name] = Hash.new
#         item_data.each do |key, value|
#           result[item_name][key] = value
#         end
#         result[item_name][:count] = 1
#       end
#     end
#   end
#   result
# end

# def apply_coupons(cart, coupons)
#   couponed_cart = cart.clone

#   # find couponed item
#   cart.each do |item_name, item_data|
#     coupons.each do |coupon|
#       if coupon[:item] == item_name && item_data[:count] - coupon[:num] >= 0
#         couponed_cart[item_name][:count] -= coupon[:num] # subtract quantity indicated on coupon

#         # add discounted rate to consolidated cart line
#         if !couponed_cart.include?("#{item_name} W/COUPON")
#           couponed_cart["#{item_name} W/COUPON"] = Hash.new
#           couponed_cart["#{item_name} W/COUPON"][:price] = coupon[:cost]
#           couponed_cart["#{item_name} W/COUPON"][:clearance] = item_data[:clearance]
#           couponed_cart["#{item_name} W/COUPON"][:count] = 1
#         else
#           couponed_cart["#{item_name} W/COUPON"][:count] += 1
#         end
#       end
#     end
#   end
#   couponed_cart
# end

# def apply_clearance(cart)
#   cart.each do |item_name, item_data|
#     if item_data[:clearance]
#       item_data[:price] = (0.8 * item_data[:price]).round(2)
#     end
#   end
# end

# def checkout(cart, coupons)
#   subtotal_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
#   subtotal = 0.0;
#   subtotal_cart.each do |item_name, item_data|
#     subtotal += item_data[:count] * item_data[:price]
#   end
#   subtotal > 100 ? (0.9 * subtotal).round(2) : subtotal
# end
