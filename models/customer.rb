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

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
