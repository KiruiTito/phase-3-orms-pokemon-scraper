require 'sqlite3'

class Pokemon
  attr_accessor :name, :type, :level

  def initialize(name:, type:, level:)
    @name = name
    @type = type
    @level = level
  end

  def save
    db = SQLite3::Database.open('db/pokemon.db')
    sanitized_name = SQLite3::Database.quote(@name)
    sanitized_type = SQLite3::Database.quote(@type)
    db.execute("INSERT INTO pokemons (name, type, level) VALUES (?, ?, ?)",
               [sanitized_name, sanitized_type, @level])
    db.close
  end

  def self.find_by_name(name)
    db = SQLite3::Database.open('db/pokemon.db')
    sanitized_name = SQLite3::Database.quote(name)
    result = db.execute("SELECT * FROM pokemons WHERE name = ?", [sanitized_name])
    db.close
    # Process the result and return a Pokemon object
  end
end
