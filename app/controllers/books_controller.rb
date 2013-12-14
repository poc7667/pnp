class BooksController < ApplicationController
  include BooksHelper
  # GET /books
  # GET /books.json
  def index
    #for searching
    # @existed_books = Book.all
    # @existed_books = Book.paginate(:page => params[:page], :per_page => 20, :order => 'updated_at DESC')
    @existed_books = Book.available.paginate(:page => params[:page], :per_page => 20, :order => 'updated_at DESC')

    # for creating
    @book = Book.new
    #respond_to do |format|
    #format.html # index.html.erb
    #format.json { render json: @books }
    #end
  end

  def search
    @books = Book.search do
      ap(params[:query])
      keywords params[:query]
      # paginate(:page => params[:page], :per_page => 20, :order => 'updated_at DESC')
      # paginate :page => params[:page] || 1, :per_page => 10
    end
    @books.each_hit_with_result do |hit, found_book|
      ap(found_book.price)
      ap(found_book.sale_type)
    end

    @existed_books = @books.results

    respond_to  do |format|
      format.html # show.html.erb        
      format.js{ render :action => "render_found_books"}

      #render_found_books.js 不能加上開頭底線
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
      format.js
    end
  end

  def print_barcode
    puts "print_barcode"
    get_barcode("lala barcode poc")
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|

      if @book.save
        format.html { redirect_to action: "index", notice: 'successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
        # format.js
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
        # format.js
      end

      format.js


      # if @book.save
      #     respond_with( @book, :status => :created, :location => @book ) do |format|
      #         format.html do
      #             if request.xhr?
      #                 render :partial => "book/show", :layout => false
      #             end
      #         end
      #     end
      # else
      #     respond_with( @book.errors, :status => :unprocessable_entity ) do |format|
      #         format.html do
      #             if request.xhr?
      #                 render :partial => "book/new", :locals => { :book => @book }, :layout => false
      #             else
      #                 render :action => :new
      #             end
      #         end
      #     end
      # end


    end #respond_to
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
      format.js
    end
  end
end