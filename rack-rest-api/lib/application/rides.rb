require 'json'
require 'byebug'

module Application
  class Rides
    include Helpers

    def call(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @current_user = Database::Users.get(@request.env['rides_app.current_user'])

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
      respond_with_object(
        Database::Rides.all_from_user(@current_user[:id])
      )
    end

    def show
      id = @request.path_info.split('/').last.to_i
      ride = Database::Rides.get(id)
      return missing("No ride found with id #{id}") if ride.nil?

      return unauthorized if ride[:user_id] != @current_user[:id]

      respond_with_object(ride)
    end

    def create
      ride = JSON.parse(@request.body.read)
      return respond_with_message('user_id field is required', 400) if ride['user_id'].nil?

      return unauthorized if ride['user_id'] != @current_user[:id]

      created_ride = Database::Rides.add(ride)
      respond_with_object(created_ride)
    rescue JSON::ParserError
      respond_with_message('Invalid JSON', 400)
    end
  end
end
