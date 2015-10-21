#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true
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
		erb "<h1>error</h1>"
	end
	
	#hh = { :user => "Enter name", :phone => "Enter phone", :time => "Enter date"}

	#@error = hh.select {|key,_| params[key] == ""}.values.join(", ")
	#if @error != ""
	#	return erb :visit
	#end


end