require_relative '../models/robot.rb'
require 'pry'

class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  not_found do
    erb :error
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

    erb :index
  end
end
