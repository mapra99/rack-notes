require 'json'

module Application
  class Rides
    include Helpers

    def call(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new

      case @request.path_info
      when @request.post? && ''
        create
      when @request.get? && ''
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
      respond_with_object(Database::Rides.all)
    end

    def show
      id = @request.path_info.split('/').last.to_i
      ride = Database::Rides.get(id)
      if ride.nil?
        missing("No ride found with id #{id}")
      else
        respond_with_object(ride)
      end
    end

    def create
      ride = JSON.parse(@request.body.read)
      if ride['user_id'].nil?
        respond_with_message('user_id field is required', 400)
      else
        created_ride = Database::Rides.add(ride)
        respond_with_object(created_ride)
      end
    rescue JSON::ParserError
      respond_with_message('Invalid JSON', 400)
    end
  end
end
