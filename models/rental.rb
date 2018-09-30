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
  
end
