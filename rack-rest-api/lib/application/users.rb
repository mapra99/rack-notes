module Application
  class Users
    include Helpers

    def call(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new

      case @request.path_info
      when ''
        index
      when %r{/\d+}
        show
      else
        missing
      end

      @response.finish
    end

    private

    def index
      respond_with_object(Database::Users.all)
    end

    def show
      id = @request.path_info.split('/').last.to_i
      user = Database::Users.get(id)
      if user.nil?
        missing("No user with id #{id}")
      else
        respond_with_object(user)
      end
    end
  end
end
