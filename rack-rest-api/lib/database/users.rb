require 'byebug'
module Database
  class Users
    def self.all
      USERS
    end

    def self.get(id)
      all[id]
    end

    def self.get_by_api_key(key)
      all
        .find { |_, user| user[:api_key] == key }
        &.first
    end

    USERS = {
      1 => { name: 'Jason', bike: 'Cannondale', api_key: 'aaaaaa' },
      2 => { name: 'Coraline', bike: 'Trek', api_key: 'bbbbbb' }
    }.freeze
  end
end
