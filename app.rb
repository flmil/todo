require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra'
require 'sinatra/json'
require './models.rb'
require 'open-uri'
require 'time'
require 'sinatra/activerecord'

enable :sessions

helpers do
	def current_user
		User.find_by(id: session[:user])
	end
end

before '/tasks' do
	if current_user.nil?
		redirect '/'
	end
end

get '/' do
	if current_user.nil?
		@tasks = Tasks.none
	else
		@tasks = current_user.tasks
	end
	erb :index
end

get '/signup' do
	erb :sign_up
end

post '/signup' do
	user = User.create(
		name:                  params[:name],
		password:              params[:password],
		password_confirmation: params[:password_confirmation]
	)

	if user.persisted?
		session[:user] = user.id
	end

	redirect '/'
end

get '/signin' do
	erb :sign_in
end

post '/signin' do
	user = User.find_by(name: params[:name])
	if user && user.authenticate(params[:password])
		session[:user] = user.id
	end

	redirect '/'
end

get '/signout' do
	session[:user] = nil
	redirect '/'
end

get '/tasks/new' do
	erb :new
end

post '/tasks' do
	current_user.tasks.create(title: params[:title])
	redirect '/'
end

