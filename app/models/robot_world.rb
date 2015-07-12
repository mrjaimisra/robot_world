require 'yaml/store'
require_relative 'robot'

class RobotWorld

  def self.database
    if ENV['ROBOT_WORLD_ENV'] == 'test'
      @database ||= YAML::Store.new("db/robot_world_test")
      # @database ||= Sequel.sqlite("db/robot_world_test_sqlite3")
    else
      @database ||= YAML::Store.new("db/robot_world")
      # @database ||= Sequel.sqlite("db/robot_world")
    end
  end

  def self.create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << {   "id" => database['total'],
      "name" => robot[:name],
      "city" => robot[:city],
      "state" => robot[:state],
      "avatar" => robot[:avatar],
      "birthdate" => robot[:birthdate],
      "datehired" => robot[:datehired],
      "department" => robot[:department]
      }
    end
  end

  def self.raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    raw_robots.map { |data| Robot.new(data) }
  end

  def self.raw_robot(id)
    raw_robots.find { |robot| robot['id'] == id }
  end

  def self.find(id)
    Robot.new(raw_robot(id))
  end

  def self.update(id, robot)
    database.transaction do
      target = database['robots'].find { |row| row["id"] == id}
      target["name"]       = robot[:name]
      target["city"]       = robot[:city]
      target["state"]      = robot[:state]
      target["avatar"]     = robot[:avatar]
      target["birthdate"]  = robot[:birthdate]
      target["datehired"]  = robot[:datehired]
      target["department"] = robot[:department]
    end
  end

  def self.delete(id)
    database.transaction do
      database['robots'].delete_if { |row| row["id"] == id}
    end
  end

  def self.average
    size = raw_robots.size
    years = raw_robots.map do |robot|
      robot["birthdate"][-4..-1].to_i
    end.reduce(:+)
    if years == nil
      0
    else
      (Time.new.year - (years / size))
    end
  end

  def self.find_years_hired
    years_hired = raw_robots.map do |robot|
      robot["datehired"][-4..-1]
    end
    count = Hash.new(0)
    years_hired.each do |year|
      count[year] += 1
    end
    count.map do |year, quantity|
      if quantity == 1
        "#{quantity} bot was hired in #{year}."
      else
        "#{quantity} bots were hired in #{year}."
      end
    end
  end

  def self.find_quantity_in_department
    departments = raw_robots.map do |robot|
      robot["department"]
    end
    counts = Hash.new(0)
    departments.each do |department|
      counts[department] += 1
    end
    counts.map do |department, quantity|
      if quantity == 1
        "#{quantity} bot works in #{department}."
      else
        "#{quantity} bots work in #{department}."
      end
    end
  end

  def self.find_quantity_in_city
    cities = raw_robots.map do |robot|
      robot["city"]
    end
    counts = Hash.new(0)
    cities.each do |city|
      counts[city] += 1
    end
    counts.map do |city, quantity|
      if quantity == 1
        "#{quantity} robot is from #{city}."
      else
        "#{quantity} robots are from #{city}."
      end
    end
  end

  def self.find_quantity_for_state
    states = raw_robots.map do |robot|
      robot["state"]
    end
    counts = Hash.new(0)
    states.each do |state|
      counts[state] += 1
    end
    counts.map do |state, quantity|
      if quantity == 1
        "#{quantity} robot is from #{state}."
      else
        "#{quantity} robots are from #{state}."
      end
    end
  end

  def self.delete_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
    end
  end
end