class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # if req.path.match(/items/)
    #   @@items.each do |item|
    #     resp.write "#{item}\n"
    #   end
    # elsif req.path.match(/search/)
    #   search_term = req.params["q"]
    #   resp.write handle_search(search_term)
    if req.path.match(/add/)
      # puts @@cart
      # puts "--"
      # puts @@items
      item = req.params["item"]
      if @@items.include?(item)
        resp.write add(item)
      else
        resp.write "We don't have that item"
      end
    elsif req.path.match(/cart/) && @@cart == []
      resp.write "Your cart is empty"
    elsif req.path.match(/cart/)
      @@cart.each do |item|
          resp.write "#{item}\n"
      end
    end
    resp.finish
  end

  def add(item)
    @@cart << item
    "added #{item}\n"
  end


  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
