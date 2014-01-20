require 'yaml/store'

class Pet

  attr_reader :name, :description

  def initialize(attributes = {})
    @name = attributes["name"]
    @description = attributes["description"]
  end

  def self.all
    raw_pets.map do |data|
      new(data)
    end
  end

  def self.raw_pets
    database.transaction do |db|
      db['pets'] || []
    end
  end

  def save
    database.transaction do |db|
      database['pets'] ||= []
      database['pets'] << {"name" => name, "description" => description}
    end
  end

  def self.delete(position)
    database.transaction do
      database['pets'].delete_at(position)
    end
  end

  def self.find(id)
    raw_pet = find_raw_pet(id)
    new(raw_pet)
  end

  def self.find_raw_pet(id)
    database.transaction do
      database['pets'].at(id)
    end
  end

  def self.update(id, data)
    database.transaction do
      database['pets'][id] = data
    end
  end

  def self.database
    @database ||=YAML::Store.new("pets")
  end

  def database
    Pet.database
  end

end
