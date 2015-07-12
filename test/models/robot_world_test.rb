require_relative '../test_helper'

class RobotWorldTest < Minitest::Test
  def test_it_creates_a_new_robot
    RobotWorld.create({   :name => "bill",
                                  :city => "roboville",
                                  :state => "roboland",
                                  :avatar => "http://robohash.org/bill",
                                  :birthdate => "01/01/2001",
                                  :datehired => "02/02/2002",
                                  :department => "human resources"
                      })

    robot = RobotWorld.find(1)

    assert_equal "bill", robot.name
    assert_equal "roboville", robot.city
    assert_equal "roboland", robot.state
    assert_equal "http://robohash.org/bill", robot.avatar
    assert_equal "01/01/2001", robot.birthdate
    assert_equal "02/02/2002", robot.datehired
    assert_equal "human resources", robot.department
  end

  def test_it_finds_all_robots
    RobotWorld.create({   :name => "bill",
                          :city => "roboville",
                          :state => "roboland",
                          :avatar => "http://robohash.org/bill",
                          :birthdate => "01/01/2001",
                          :datehired => "02/02/2002",
                          :department => "human resources"
                      })

    RobotWorld.create({   :name => "john",
                          :city => "madrid",
                          :state => "spain",
                          :avatar => "http://robohash.org/john",
                          :birthdate => "10/10/1001",
                          :datehired => "20/20/2222",
                          :department => "accounting"
                      })

    robots = RobotWorld.all

    assert_equal "john", robots[1].name
    assert_equal "roboland", robots[0].state
    assert_equal "20/20/2222", robots[1].datehired
    end


  def test_it_finds_a_robot_by_id
    RobotWorld.create({   :name => "bill",
                          :city => "roboville",
                          :state => "roboland",
                          :avatar => "http://robohash.org/bill",
                          :birthdate => "01/01/2001",
                          :datehired => "02/02/2002",
                          :department => "human resources"
                      })

    RobotWorld.create({   :name => "john",
                          :city => "madrid",
                          :state => "spain",
                          :avatar => "http://robohash.org/john",
                          :birthdate => "10/10/1001",
                          :datehired => "20/20/2222",
                          :department => "accounting"
                      })

    assert_equal "accounting", RobotWorld.find(2).department
  end

  def test_it_updates_a_robots_information
    RobotWorld.create({   :name => "bill",
                          :city => "roboville",
                          :state => "roboland",
                          :avatar => "http://robohash.org/bill",
                          :birthdate => "01/01/2001",
                          :datehired => "02/02/2002",
                          :department => "human resources"
                      })

    RobotWorld.update(1,  { :id => 1,
                            :name => "bill",
                            :city => "roboville",
                            :state => "roboland",
                            :avatar => "http://robohash.org/bill",
                            :birthdate => "01/01/2001",
                            :datehired => "02/02/2002",
                            :department => "sales"
                       })

    assert_equal "sales", RobotWorld.find(1).department
  end

  def test_it_deletes_a_robots_information
    robot = RobotWorld.create({   :name => "bill",
                                  :city => "roboville",
                                  :state => "roboland",
                                  :avatar => "http://robohash.org/bill",
                                  :birthdate => "01/01/2001",
                                  :datehired => "02/02/2002",
                                  :department => "human resources"
                              })

    RobotWorld.create({   :name => "john",
                          :city => "madrid",
                          :state => "spain",
                          :avatar => "http://robohash.org/john",
                          :birthdate => "10/10/1001",
                          :datehired => "20/20/2222",
                          :department => "accounting"
                      })

    RobotWorld.delete(1)

    assert_equal "accounting", RobotWorld.find(2).department
    refute RobotWorld.all.include?(robot)
  end
end
