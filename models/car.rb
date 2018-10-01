require_relative('../db/sql_runner')

class Car
  attr_reader :id
  attr_accessor :type, :rental_cost

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @rental_cost = options['rental_cost']
  end

  def save()
    sql = "INSERT INTO cars (type, rental_cost)
    VALUES ($1, $2)
    RETURNING id"

    values = [@type, @rental_cost]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM cars"

    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM cars"
    cars = SqlRunner.run(sql)
    return cars.map{|car_hash| Car.new(car_hash)}

  end

  def delete()
    sql = "DELETE FROM cars
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
