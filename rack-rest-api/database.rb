class Database
  def self.users
    USERS
  end

  def self.user(id)
    USERS[id]
  end

  def self.rides
    RIDES
  end

  def self.ride(id)
    RIDES[id]
  end

  private

  USERS = {
    1 => { name: 'Jason', bike: 'Cannondale' },
    2 => { name: 'Coraline', bike: 'Trek' }
  }.freeze

  RIDES = {
    1 => { user_id: 1, title: "Morning Commute", date: "2020-09-28" },
    2 => { user_id: 1, title: "Evening Commute", date: "2020-09-29" },
  }.freeze
end
