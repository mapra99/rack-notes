require 'json'

module Application
  module Helpers
    def respond_with_message(message, status = 200)
      @response.status = status
      @response.write(message)
    end

    def respond_with_object(object, status = 200)
      @response.headers['Content-Type'] = 'application/json'
      respond_with_message(JSON.generate(object), status)
    end

    def missing(message = 'Not found!')
      respond_with_message(message, 404)
    end

    def unauthorized(message = 'Forbidden!')
      respond_with_message(message, 403)
    end
  end
end
