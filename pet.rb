require 'yaml/store'

class Pet

  attr_reader :name, :description

  def initialize(name, description)
    @name = name
    @description = description
  end

  def self.all
    raw_pets.map do |data|
      new(data[:name], data[:description])
    end
  end

  def self.raw_pets
    database.transaction do |db|
      db['pets'] || []
    end
  end

  def save
    database.transaction do |db|
      db['pets'] ||= []
      db['pets'] << {name: name, description: description}
    end
  end

  def self.database
    @database ||=YAML::Store.new("pets")
  end

  def database
    Pet.database
  end

end
