class BooksController < ApplicationController
   before_action :authenticate_user!

   before_action :ensure_correct_user, only: [:edit, :update, :destroy]

    def index
    @book = Book.new
     @user = current_user
     @books = Book.all
    end

    def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:complete] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    @user = current_user
    @books = Book.all
    render :index
    end
    end

    def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new

    end

    def edit
      @book = Book.find(params[:id])
    end

    def update
      @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:complete] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
    render:edit
    end
    end

    def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    end

    private

    def book_params
    params.require(:book).permit(:title, :body)
    end

    def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
    end

end
