require 'byebug'
module Middlewares
  class KeyManager
    def initialize(app, _opts = {})
      @app = app
    end

    def call(env)
      api_key = env['HTTP_API_KEY']
      user = Database::Users.get_by_api_key(api_key)

      if user.nil?
        [403, {}, ['Forbidden']]
      else
        env["rides_app.current_user"] = user[:id]
        @app.call(env)
      end
    end
  end
end
