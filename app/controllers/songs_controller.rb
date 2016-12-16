class SongsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @songs = Song.all
    @adds = Add.all
  end

  def create
    if params[:title].to_s == '' || params[:artist].to_s == ''
      flash[:create_error] = "Can't be blank"
      if params[:title].length <= 2 || params[:artist].length <= 2
        flash[:error] = "Must be longer than 2 characters"
        redirect_to "/songs"
      end
    elsif params[:title].length <= 2 || params[:artist].length <= 2
      flash[:error] = "Must be longer than 2 characters"
      redirect_to '/songs'
    else
      # @user = User.find(params[:user_id])
      @song = Song.create(user_id:params[:user_id], artist:params[:artist], title:params[:title])
      redirect_to "/songs"
    end
  end

  def show
    @users = User.all
    @song = Song.find_by_id(params[:id])
    # @adds = Add.select(:).where(:user_id => session[:user_id])
    @adds = Add.where(:song_id => params[:id])
    # @user_adds = Add.where(:song_id => params[:id]).joins({users: :songs}).group('user_id').all
  end

end
