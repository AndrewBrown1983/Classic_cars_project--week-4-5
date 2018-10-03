require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('./models/car')
require_relative('./models/customer')
require_relative('./models/rental')
also_reload('./models/*')

get "/" do
  erb(:home)
end

get "/customer_index" do
  @customers = Customer.all()
  erb(:customer_index)
end

get "/car_index" do
  @cars = Car.all()
  erb(:car_list)
end

get "/rental_index" do
  @rentals = Rental.all()
  erb(:rental_list)
end

get "/new_car" do
  erb(:new_car)

end

get "/new_customer" do
  erb(:new_customer)
end

get "/new_rental" do
  @cars = Car.available_cars()


  @customers = Customer.all()
  erb(:new_rental)
end

post "/customer_index" do
  @customer = Customer.new(params)
  @customer.save()
  redirect to '/customer_index'
end

post "/car_index" do
  @car = Car.new(params)
  @car.save()
  redirect to '/car_index'
end

post "/rental_index" do
  rental = Rental.new(params)
  rental.save()

  car = Car.find(params[:car_id])
  car.hire_car

  redirect to '/rental_index'
end

post "/rental_index/:id/return" do
  rental = Rental.find(params[:id])
  car = rental.car()
  car.return_car()

  Rental.delete(rental.id)
  redirect to "/rental_index"

end

post "/customer_index/:id/delete" do
  customer = Customer.find(params[:id])
  customer.delete()
  redirect to "/customer_index"
end



get "/customer_index/:id/edit" do
  @customer = Customer.find(params[:id])
  erb(:edit)
end

post "/customer_index/:id/update" do
  customer = Customer.new(params)
  customer.update()
  redirect to "/customer_index"
end

post "/car_index/:id/delete" do
  car = Car.find(params[:id])
  car.delete()
  redirect to "/car_index"

end
