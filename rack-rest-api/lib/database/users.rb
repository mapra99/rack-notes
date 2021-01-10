module Database
  class Users
    def self.all
      USERS
    end

    def self.get(id)
      USERS[id]
    end

    USERS = {
      1 => { name: 'Jason', bike: 'Cannondale' },
      2 => { name: 'Coraline', bike: 'Trek' }
    }
  end
end
