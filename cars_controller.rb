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

get "/new_car" do
  erb(:new_car)

end

get '/car_index/:id' do
  @car = Car.find(params[:id])
  erb(:show)
end

post "/car_index" do
  @car = Car.new(params)
  @car.save()
  redirect to '/car_index'
end

post "/car_index/:id/delete" do
  car = Car.find(params[:id])
  car.delete()
  redirect to "/car_index"

end
