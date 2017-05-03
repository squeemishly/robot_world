require_relative '../models/robot.rb'
require 'pry'

class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  not_found do
    erb :error
  end

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = Robot.all
    erb :index
  end

  get '/robots/new' do
    erb :new_robot
  end

  post '/robots' do
    robot = Robot.new(params)
    robot.save
    redirect '/robots'
  end

  get '/robot/:id' do
    @robot = Robot.find(params[:id])
    erb :one_robot
  end

  get '/robot/:id/edit' do
    @robot = Robot.find(params[:id])
    erb :edit_robot
  end

  set :method_override, true
  put '/robot/:id' do |id|
    Robot.update(id.to_i, params)
    redirect "/robot/#{id}"
  end
end
