#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :barber, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
	validates :name, presence: true
end

before do
	@barbers = Barber.all
end

get '/' do
	@barbers = Barber.order "created_at desc"
	erb :index
end


get '/about' do
	#@error = "smth wrong"
	erb :about
end
get '/visit' do
	#@barbers = Barber.all
	erb :visit
end

get '/contacts' do
	
	erb :contacts
end
post "/visit" do
	#@barbers = Barber.all
	@booking = Client.new params[:client]
	if @booking.save
		erb "#{@booking.name}"
	else
		@error = @booking.errors.full_messages.first
		erb :visit
	end
end

get "/barber/:id" do
	@barber = Barber.find(params[:id])
	erb :barber
end

get "/bookings" do
	@clients= Client.order("created_at DESC")
	erb :bookings
end

get "/client/:id" do
	@client = Client.find(params[:id])
	erb :client
end