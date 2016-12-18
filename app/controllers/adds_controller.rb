class AddsController < ApplicationController
  def create
		@adds = Add.find_by_user_id_and_song_id(session[:user_id],params[:song_id])
		if @adds
			@adds.increment!(:add_count)
			# @adds.save()
      redirect_to request.referer
		else
			@adds = Add.create(user_id:session[:user_id], song_id:params[:song_id],add_count:1)
      redirect_to request.referer
		end
  end

  def show

  end

end
