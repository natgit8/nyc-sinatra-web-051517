class LandmarksController < ApplicationController

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/:id/edit' do
    landmark_id = params[:id].to_i
    if Landmark.pluck(:id).include?(landmark_id)
      @landmark = Landmark.find(params[:id])
      erb :'landmarks/edit'
    end
  end

  put '/landmarks/:id' do
    landmark_id = params[:id].to_i
    if Landmark.pluck(:id).include?(landmark_id)
      @landmark = Landmark.find(params[:id])
      @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @landmark.save
    end
    erb :'landmarks/show'
  end


end
