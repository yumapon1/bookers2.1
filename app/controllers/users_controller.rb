class UsersController < ApplicationController
  before_action :authenticate_user!
before_action :ensure_current_user, only: [:edit,:update,:destroy]

def edit
 @user = User.find(params[:id])
 if @user == current_user
   render :edit
 else
   redirect_to user_path(current_user)
 end
end



  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    #@books= Book.all
    #@books = Book.where(user_id: @user.id)

  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to  user_path(current_user)
    else
      render :edit
    end
  end



 private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def  ensure_current_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end