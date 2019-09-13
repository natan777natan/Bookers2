class BooksController < ApplicationController

	def show
		@newbook = Book.new
		@book = Book.find(params[:id])
		@user = current_user
		# @book.user_id = current_user.id
	end
	def index
		@newbook = Book.new
		@user = current_user
		# @book.user_id = current_user.id
		@books = Book.all

	end
	def new
		@book = Book.new
	end

    def create
	  	@newbook = Book.new(book_params)
	  	@newbook.user_id = current_user.id
	  	if @newbook.save
	  		redirect_to book_path(@newbook.id)
	  		flash[:book] = "You have creatad book successfully."
	  	else
	  		@user = current_user
	  		@books = Book.all
	  		render 'index'
	  	end
    end

	def edit
		@book = Book.find(params[:id])
		@user = current_user
	end
	def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
           redirect_to book_path
           flash[:book] = "You have updated book successfully."
        else
        	flash[:book] = "error!"
        	render 'edit'
        end
	end
	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	before_action :authenticate_user! #ログインしていないときはログイン画面へredirectになる。protect_from_forgery with: :exceptionより後におく。
    before_action :correct_book, only: [:edit, :update]
    private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def correct_book
      @book = Book.find(params[:id])
      @user = current_user.id
    if @user != @book.user_id
      redirect_to books_path
      flash[:book] = "error!"
    end
    end

end


