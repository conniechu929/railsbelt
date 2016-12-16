class UsersController < ApplicationController
  # before_action :require_login, except: [:new, :create, :login]
  # before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.new
  end

  def create
    if params[:user][:first_name].to_s == '' || params[:user][:last_name].to_s == '' || params[:user][:email].to_s == '' || params[:user][:password].to_s == ''
      flash[:create_error] = "can't be blank"
      if params[:user][:password].to_s != params[:user][:password_confirmation].to_s
        flash[:error] = "Passwords do not match"
        redirect_to "/main"
      end
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
    if User.find_by_email(params[:user][:email]).nil?
      flash[:noemail] = "Email does not exist"
      redirect_to "/main"
    end
    @user = User.find_by_email(params[:user][:email])
    if @user.authenticate(params[:user][:password]) == false
      flash[:error] = "Invalid"
      redirect_to "/main"
    else
      session[:user_id] = @user.id
      redirect_to "/songs"
    end
  end

  def show
    @songs = Song.all
    @user = User.find_by_id(session[:user_id])
    @adds = Add.where(:user_id => session[:user_id])
    # @adds = Add.find_by_user_id(session[:user_id])
  end

  def logout
    reset_session
    redirect_to "/main"
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
