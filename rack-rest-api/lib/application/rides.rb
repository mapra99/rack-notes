require 'json'

module Application
  class Rides
    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      if request.path_info.empty?
        if request.post?
          ride = JSON.parse(request.body.read)
          created_ride = Database::Rides.add(ride)
          response.headers['Content-Type'] = 'application/json'
          response.write(JSON.generate(created_ride))
        elsif request.get?
          response.headers['Content-Type'] = 'application/json'
          response.write(JSON.generate(Database::Rides.all))
        else
          response.status = 404
          response.write('Not Found!')
        end
      elsif request.path_info =~ %r{/\d+}
        id = request.path_info.split('/').last.to_i
        response.headers['Content-Type'] = 'application/json'
        response.write(JSON.generate(Database::Rides.get(id)))
      else
        response.status = 404
        response.write('Not Found!')
      end

      response.finish
    end
  end
end
