class Pet

  attr_reader :name, :description

  def initialize(attributes = {})
    @name = attributes["name"]
    @description = attributes["description"]
  end

  def save
    database.transaction do |db|
      database['pets'] ||= []
      database['pets'] << {"name" => name, "description" => description}
    end
  end

  def database
    Pet.database
  end

end
