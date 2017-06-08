require "pry"

class FiguresController < ApplicationController

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
    @figure.titles << current_title unless current_title.nil?
    @landmark = current_landmark
    @landmark.figure = @figure
    @landmark.save
    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    figure_id = params[:id].to_i
    if Figure.pluck(:id).include?(figure_id)
      @figure = Figure.find(params[:id])
      erb :'figures/edit'
    end
  end

  put '/figures/:id' do
    figure_id = params[:id].to_i
    if Figure.pluck(:id).include?(figure_id)
      @figure = Figure.find(params[:id])
      @figure.update(name: params[:figure][:name])
      @figure.save
      landmark = current_landmark
      landmark.figure = @figure
      landmark.save
      @landmarks = Landmark.all
    end
    erb :'figures/show'
  end

  private
    def current_title
      if !params[:title][:name].empty?
        title = Title.create(name: params[:title][:name])
      else
        title = Title.find_by_id(params[:figure][:title_id])
      end
    end

    def current_landmark
      if !params[:landmark][:name].empty?
        landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      else
        landmark = Landmark.find_by_id(params[:figure][:landmark_id])
      end
    end
end
