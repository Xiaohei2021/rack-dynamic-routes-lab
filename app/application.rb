require 'pry'
class Application

  @@items = [Item.new("apple",1.99)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)

      # /items/<ITEM NAME>
  
      last_item = req.path.split("/").last

      if item = @@items.detect {|item| item.name == last_item}
              # binding.pry
                resp.write "#{item.price}\n"
            
        else 
            resp.write "Item not found"            
            resp.status = 400

        end

    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end 