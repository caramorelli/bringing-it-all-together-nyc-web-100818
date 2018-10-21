

class Dog 
  
  attr_accessor :id, :name, :breed
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name VARCHAR(255), 
        breed VARCHAR(255)
      )
      SQL
      
      DB[:conn].execute(sql)
  end 
  
  def self.drop_table
     DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  end 
  
  def self.create(attr_hash)
    new_dog = new_from_db(attr_hash.values)
    new_dog.save
    new_dog
    
  end 
  
  def self.find_by_id
    
  end 
  
  def self.find_or_create_by(attr_hash)
    self.id.nil? ? 
  end 
  
  def self.new_from_db(row)
    self.new(id: row[0], name: row[1], breed: row[2])
  end 
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM dogs WHERE name = ? LIMIT 1
    SQL
    
    DB[:conn].execute(sql, name).map {  |row| self.new_from_db(row) }.first
  end 

  
  def initialize(id: nil, name:, breed:)
    @id, @name, @breed = id, name, breed
  end 
  
   def attribute(pair_hash)
     self.new(name: pair_hash.name, breed: pair_hash.breed)
  end
  
  def save 
    sql = <<-SQL 
      INSERT INTO dogs (name, breed) VALUES( ?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.breed)
     @id = DB[:conn].execute("SELECT last_insert_index_id FROM dogs")[0][0]
  end 
  
  
  
end 