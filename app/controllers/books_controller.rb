class BooksController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_current_user, only: [:edit,:update,:destroy]

 def new
    @book = Book.new
end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice: 'Book was successfully updated.'
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path,alert: 'Book was successfully destroyed.'
  end

   private
  # ストロングパラメータ
  def book_params
   params.require(:book).permit(:title, :body)
  end

   def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
   end

   def  ensure_current_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
     redirect_to books_path
    end
   end
end