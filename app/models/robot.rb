require 'sqlite3'
require 'pry'

class Robot
  attr_reader :name,
              :city,
              :state,
              :department,
              :id

  def initialize(robot_params)
    @database = SQLite3::Database.new('db/robot_world_development.db')
    @database.results_as_hash = true
    @name = robot_params["name"]
    @city = robot_params["city"]
    @state = robot_params["state"]
    @department = robot_params["department"]
    @id = robot_params["id"] if robot_params["id"]
  end

  def save
    @database.execute("INSERT INTO robots (name, city, state, department) VALUES (?, ?, ?, ?);", @name, @city, @state, @department)
  end

  def self.all
    robots = database.execute("SELECT * FROM robots")
    robots.map do |robot|
      Robot.new(robot)
    end
  end

  def self.find(id)
    robot = database.execute("SELECT * FROM robots WHERE id=?", id).first
    Robot.new(robot)
  end

  def self.update(id, robot_params)
    database.execute("UPDATE robots
                      SET name = ?,
                          city = ?,
                          state = ?,
                          department = ?
                      WHERE id = ?;",
                      robot_params["robot"]["name"],
                      robot_params["robot"]["city"],
                      robot_params["robot"]["state"],
                      robot_params["robot"]["department"],
                      id)
    Robot.find(id)
  end

  def self.terminate(id)
    database.execute("DELETE FROM robots
                      WHERE id=?;", id)
  end

  def self.database
    database = SQLite3::Database.new('db/robot_world_development.db')
    database.results_as_hash = true
    database
  end
end
