require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_it_assigns_attributes_correctly
    robot = Robot.new({ "name" => "roboname",
                        "city" => "robot city",
                        "state" => "robot state",
                        "avatar" => "http://robohash.org/roboname",
                        "birthdate" => "02/02/2002",
                        "datehired" => "01/01/2001",
                        "department" => "robot department"
                      })

    assert_equal "roboname", robot.name
    assert_equal "robot city", robot.city
    assert_equal "robot state", robot.state
    assert_equal "http://robohash.org/roboname", robot.avatar
    assert_equal "02/02/2002", robot.birthdate
    assert_equal "01/01/2001", robot.datehired
    assert_equal "robot department", robot.department

  end
end