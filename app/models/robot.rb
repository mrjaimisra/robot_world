class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :avatar,
              :birthdate,
              :datehired,
              :department


  def initialize(data)
    @id         = data["id"]
    @name       = data["name"]
    @city       = data["city"]
    @state      = data["state"]
    @avatar     = data["avatar"]
    @birthdate  = data["birthdate"]
    @datehired  = data["datehired"]
    @department = data["department"]
  end
end