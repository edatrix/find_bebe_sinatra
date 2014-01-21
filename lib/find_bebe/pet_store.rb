require 'yaml/store'

class PetStore

  def self.all
    raw_pets.map do |data|
      Pet.new(data)
    end
  end

  def self.create(attributes)
    database.transaction do
      database['pets'] ||= []
      database['pets'] << attributes
    end
  end

  def self.raw_pets
    database.transaction do |db|
      db['pets'] || []
    end
  end

  def self.delete(position)
    database.transaction do
      database['pets'].delete_at(position)
    end
  end

  def self.find(id)
    raw_pet = find_raw_pet(id)
    Pet.new(raw_pet)
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
    @database ||= YAML::Store.new("db/pets")
  end

end
