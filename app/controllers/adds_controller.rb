class AddsController < ApplicationController
  def create

    @add = Add.create(add_count:params[:add_count],user_id:session[:user_id], song_id:params[:song_id])
    redirect_to request.referer
  end

  def show
      # @adds = Add.select(params[:id]).group(session[:user_id])
      # redirect_to "/songs/#{params[:id]}"
  end

end
