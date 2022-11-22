class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :index
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated book successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

   def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user)
    end
  end

end
