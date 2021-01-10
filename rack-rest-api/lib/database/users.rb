require 'byebug'
module Database
  class Users
    @users = {
      1 => { name: 'Jason', bike: 'Cannondale', api_key: 'aaaaaa' },
      2 => { name: 'Coraline', bike: 'Trek', api_key: 'bbbbbb' }
    }

    class << self
      def all
        @users.map {|user| serialize(user)}
      end

      def get(id)
        all.find { |user| user[:id] == id }
      end

      def get_by_api_key(key)
        all.find { |user| user[:api_key] == key }
      end

      private

      def serialize(user)
        return if user.nil?

        {
          id: user[0],
          **user[1]
        }
      end
    end
  end
end
