require 'byebug'
module Database
  class Rides
    @rides = {
      1 => { user_id: 1, title: 'Morning Commute', date: '2020-09-28' },
      2 => { user_id: 1, title: 'Evening Commute', date: '2020-09-29' },
      3 => { user_id: 2, title: 'Evening Commute', date: '2020-09-29' },
      4 => { user_id: 2, title: 'Evening Commute', date: '2020-09-29' },
    }

    @index_pointer = 4

    class << self
      def all
        @rides.map { |ride| serialize(ride) }
      end

      def all_from_user(user_id)
        all.select { |ride| ride[:user_id] == user_id }
      end

      def get(id)
        all.find { |ride| ride[:id] == id }
      end

      def add(attrs)
        attrs.transform_keys!(&:to_sym)
        @index_pointer += 1
        @rides[@index_pointer] = attrs
      end

      private

      def serialize(ride)
        return if ride.nil?

        {
          id: ride[0],
          **ride[1]
        }
      end
    end
  end
end
