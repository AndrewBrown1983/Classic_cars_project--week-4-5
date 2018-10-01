require_relative('../db/sql_runner')

class Customer
  attr_reader :id
  attr_accessor :name, :address, :phone_number, :wallet

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @address = options['address']
    @phone_number = options['phone_number']
    @wallet = options['wallet']
  end

  def save()
    sql = "INSERT INTO customers (name, address, phone_number, wallet)
    VALUES ($1, $2, $3, $4)
    RETURNING id"

    values = [@name, @address, @phone_number, @wallet]

    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers
    SET (
      name, address, phone_number, wallet
    )
    = (
      $1, $2, $3, $4
    )
    WHERE id = $5"

    values = [@name, @address, @phone_number, @wallet, @id]

    SqlRunner.run(sql, values)
  end

  def cars()
    sql = "SELECT cars.*
    FROM cars INNER JOIN rentals
    ON cars.id = rentals.car_id
    WHERE customer_id = $1"

    values = [@id]
    cars = SqlRunner.run(sql, values)
    return cars.map{|car_hash| Car.new(car_hash)}
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map{|customer_hash| Customer.new(customer_hash)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end




end
