require 'json'

module Application
  class Rides
    def call(env)
      request = Rack::Request.new(env)
      if env['PATH_INFO'] == ''
        if request.post?
          ride = JSON.parse(request.body.read)
          Database::Rides.add(ride)
          [200, {}, ["OK"]]
        elsif request.get?
          [200, {}, [Database::Rides.all.to_s]]
        else
          [404, {}, ['Not Found!']]
        end
      elsif env['PATH_INFO'] =~ %r{/\d+}
        id = env['PATH_INFO'].split('/').last.to_i
        [200, {}, [Database::Rides.get(id).to_s]]
      else
        [404, {}, ['Not Found!']]
      end
    end
  end
end
