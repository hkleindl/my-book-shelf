class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]

  def new
    if !params[:id]
      @user = User.new
    else
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = "Welcome #{@user.username}!"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    if params[:id].to_i == current_user.id
      @user = User.find_by(id: params[:id])
      @my_books = @user.books
      @highly_rated_books = Book.highly_rated
      @popular_books = Book.popular
    else
      redirect_to user_path(current_user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)      
    end

end
