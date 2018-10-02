require_relative('../db/sql_runner')

class Rental
  attr_reader :id
  attr_accessor :car_id, :customer_id, :review

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @car_id = options['car_id']
    @customer_id = options['customer_id']
    @review = options['review']
  end


  def save()
    sql = "INSERT INTO rentals (car_id, customer_id, review)
    VALUES ($1, $2, $3)
    RETURNING id"

    values = [@car_id, @customer_id, @review]

    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE rentals
    SET (
      car_id, customer_id, review
    )
    = (
      $1, $2, $3
    )
    WHERE id = $4"

    values = [@car_id, @customer_id, @review, @id]

    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM rentals
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE
    id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values).first
    return Customer.new(result)
  end

  def car()
    sql = "SELECT * FROM cars WHERE id = $1"
    values = [@car_id]
    result = SqlRunner.run(sql, values).first
    return Car.new(result)

  end

  def self.find(id)
    sql = "SELECT * FROM rentals WHERE id = $1"
    values = [id]
    rental = SqlRunner.run(sql, values).first
    return Rental.new(rental)
  end

  def self.all()
    sql = "SELECT * FROM rentals"
    results = SqlRunner.run(sql)
    return results.map{|rental_hash| Rental.new(rental_hash)}
  end


end
