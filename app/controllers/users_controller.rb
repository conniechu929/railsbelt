class UsersController < ApplicationController
  # before_action :require_login, except: [:create, :login]
  # before_action :require_correct_user, only: [:show, :destroy]

  def index
    @user = User.new
  end

  def create
    if params[:user][:first_name].to_s == '' || params[:user][:last_name].to_s == '' || params[:user][:email].to_s == '' || params[:user][:password].to_s == '' && params[:user][:password] != params[:user][:password_confirmation]
      flash[:create_error] = "Fields can't be blank"
      flash[:error] = "Passwords do not match"
      redirect_to "/main"
    elsif params[:user][:first_name].to_s == '' || params[:user][:last_name].to_s == '' || params[:user][:email].to_s == '' || params[:user][:password].to_s == '' || params[:user][:password_confirmation].to_s == ''
      flash[:create_error] = "Fields can't be blank"
      redirect_to '/main'
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash[:error] = "Passwords do not match"
      redirect_to '/main'
    else
      if params[:user][:password] == params[:user][:password_confirmation]
        @user = User.create(user_params)
        session[:user_id] = @user.id
        redirect_to "/songs"
      end
    end
  end

  def login
    @user = User.find_by_email(params[:user][:email])
    if User.find_by_email(params[:user][:email]).nil?
      flash[:noemail] = "Email does not exist"
      redirect_to "/main"
    else
      if @user.authenticate(params[:user][:password]) == false
        flash[:error] = "Invalid"
        redirect_to "/main"
      else
        session[:user_id] = @user.id
        redirect_to "/songs"
      end
    end
  end

  def show
    @songs = Song.all
    @user = User.find_by_id(session[:user_id])
    @user_adds = User.find(params[:id])
  end

  def logout
    reset_session
    redirect_to "/main"
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
