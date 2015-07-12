require_relative "../test_helper"

class UserInteractsWithAllBots < FeatureTest
  def test_homepage_displays_welcome_message
    visit("/")
    assert_equal "/", current_path
    assert page.has_content?("Hello, Robots.")
  end

  def test_homepage_title_has_css_id_hello
    visit("/")
    within("body") do
      assert page.has_css?("#hello")
    end
  end

  def test_user_can_fill_in_robot_form
    visit("/")
    click_link("New Bot")

    assert_equal "/robots/new", current_path

    fill_in("robot[name]", with: "Reginald")
    fill_in("robot[city]", with: "Sacramento")
    fill_in("robot[state]", with: "California")
    fill_in("robot[birthdate]", with: "09/09/1999")
    fill_in("robot[datehired]", with: "03/03/2003")
    fill_in("robot[department]", with: "Loss Prevention")
    click_button("Save Bot")

    assert_equal "/robots", current_path

    within(".container") do
      assert page.has_content?("Reginald")
    end
  end

  def test_user_can_edit_a_task
    RobotWorld.create(name: "Reginald",
                              city: "Stockton",
                              state: "California",
                              birthdate: "01/01/1995",
                              datehired: "01/01/2005",
                              department: "Creative"
                              )

    robot = RobotWorld.all.first

    visit("/robots")

    assert page.has_content?("Reginald")

    click_link("edit")

    assert_equal "/robots/#{robot.id}/edit", current_path
  end

  def test_user_can_delete_a_robot
    RobotWorld.create(name: "Reginald",
                      city: "Stockton",
                      state: "California",
                      birthdate: "01/01/1995",
                      datehired: "01/01/2005",
                      department: "Creative"
    )


    visit("/robots")
    assert page.has_content?("Reginald")

    click_button("delete")

    refute page.has_content?("Reginald")
  end
end