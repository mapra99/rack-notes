module Database
  class Rides
    @rides = {
      1 => { user_id: 1, title: 'Morning Commute', date: '2020-09-28' },
      2 => { user_id: 1, title: 'Evening Commute', date: '2020-09-29' }
    }

    @index_pointer = 2

    class << self
      def all
        @rides
      end

      def get(id)
        @rides[id]
      end

      def add(attrs)
        attrs.transform_keys!(&:to_sym)
        @index_pointer += 1
        @rides[@index_pointer] = attrs
      end
    end
  end
end
