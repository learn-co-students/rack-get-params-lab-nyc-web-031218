class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

#if path is cart and cart has one or more items write cart item
#otherwise writ "cart is empty"
      if req.path.match(/cart/) && @@cart.length > 0
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
      elsif @@cart == []
        resp.write "Your cart is empty"
      end

      if req.path.match(/add/)
        #if path is add
        #item_to_add is set to the value of the "item" key (whatever item user is adding)
        #then run the method add_to_cart(item_to_add)
        item_to_add = req.params["item"]
        resp.write add_to_cart(item_to_add)
      end

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end
    #this statement must be at the end of ALL responses
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_to_cart(item_to_add)
    #if items array includs the users item
    #add to the cart array
    if @@items.include?(item_to_add)
      @@cart << item_to_add
      return "added #{item_to_add}"
    else
      return "We don't have that item"
    end
  end

end
