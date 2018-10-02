require_relative('../db/sql_runner')

class Car
  attr_reader :id
  attr_accessor :type, :rental_cost, :status

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @rental_cost = options['rental_cost']
    @status = options['status']
  end

  def save()
    sql = "INSERT INTO cars (type, rental_cost, status)
    VALUES ($1, $2, $3)
    RETURNING id"

    values = [@type, @rental_cost, @status]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM cars
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE cars
    SET (
      type, rental_cost, status
    )
    = (
      $1, $2, $3
    )
    WHERE id = $4"

    values = [@type, @rental_cost, @status, @id]

    SqlRunner.run(sql, values)
  end

  def hire_car
    sql = "UPDATE cars SET status = 'unavailable' WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.available_cars()
    sql = 'SELECT * FROM cars WHERE
    status = $1'
    values = ["available"]
    results = SqlRunner.run(sql, values)
    return results.map{|results_hash| Car.new(results_hash)}

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

  def self.find(id)
    sql = "SELECT * FROM cars WHERE id = $1"
    values = [id]
    car = SqlRunner.run(sql, values).first
    return Car.new(car)
  end



end
