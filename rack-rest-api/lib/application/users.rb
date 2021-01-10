require 'json'

module Application
  class Users
    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      if request.path_info == ''
        response.headers['Content-Type'] = 'application/json'
        response.write(JSON.generate(Database::Users.all))
      elsif request.path_info =~ %r{/\d+}
        id = request.path_info.split('/').last.to_i
        response.headers['Content-Type'] = 'application/json'
        response.write(JSON.generate(Database::Users.get(id)))
      else
        response.status = 404
        response.write('Not Found!')
      end

      response.finish
    end
  end
end
