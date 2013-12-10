# encoding: utf-8
class CartsController < ApplicationController
  load_and_authorize_resource
  include CartsHelper

  require 'pp'
  require 'pry'
  # load_and_authorize_resource

  # GET /carts
  # GET /carts.json
  def index

    @carts = Cart.all
    # @q = Book.search(params[:q])
    init_session()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
      format.js
    end
  end

  def search_customer
    # to search_customer
    @customer = Customer.search do |q|
      ap(params[:customer_query])
      q.keywords params[:customer_query]
    end

    ap("Totol Customer : #{@customer.total}")

    respond_to  do |format|
      format.js{ render :action => "found_customer"}
    end

  end

  def load_customer
    #reset session
    # session.clear
    init_session
    # load particular customer from search customer
    customer_id = params[:load_customer].to_i
    @customer = Customer.find_by_id(customer_id)
    @customer.can_downgrade
    # binding.pry
    session[:load_customer] = @customer

    @points = Order.get_points(@customer) || 0

    respond_to do |format|
      format.html
      format.js
    end

  end

  def search_book

    ap(params[:book_query])
    @existed_books = Book.search do
      keywords params[:book_query]
    end

    ap(@existed_books.total)

    @existed_books.each_hit_with_result do |hit, found_book|
      ap(found_book.price)
      ap(found_book.sale_type)
    end

    respond_to do |format|
      # format.js
      format.html
      format.js
    end
  end

  def add_item

    session[:load_customer] ||= Customer.get_guest # 他剛好是 general 就是他了阿
    @current_customer = session[:load_customer]
    session[:loaded_books] ||= []

    if params[:query].length > 0
      @book = Book.search_by_sn(params[:query])[0]
    else # not in database
      @book = generate_nonexisted_book(params[:price])
    end

    respond_to do |format|
      # format.js
      # Debug msg
      # binding.pry
      ap(@book.inspect)
      ap(session[:loaded_books])

      if @book == nil # 他輸入 sn, 但是根本就沒這本書
        flash[:notice] = "Not Exists"
        format.js { render :action => 'add_to_cart'}
      elsif  session[:loaded_books].include? @book.id
        format.js { render :action => 'add_to_cart'}
      else
        ap("Add into Array")
        @discounted_price = get_discount(@book,
                                         @current_customer)


        if @book.id != nil # if no book id , enter by manully
          ap(@book.inspect)
          session[:loaded_books] << @book.id
          ap(session[:loaded_books])
        end

        format.js { render :action => 'add_to_cart'}

      end

    end

  end


  def submit_order

    @customer = session[:load_customer] || Customer.get_guest
    # books_in_cart = .values
    @order = Order.new(customer_id: @customer.id,
                       role: @customer.role)

    @books = get_submitted_books_price(@customer,
                                       @order,
                                       params[:book_ids])
    @order.books << @books
    @customer.orders << @order

    respond_to do |format|

      if current_user
        current_user.orders << @order
        @order.save
        @customer.save
        #TODO: Customer VIP points 累計

        #Show Notice Message if GUEST's spend > 500
        if @customer.name == :GUEST.to_s
          # binding.pry
          amount = @order.actual_amount
          flash[:notice] = '可加入VIP' if amount  > Order::THRESHOULD[:VIP]
          flash[:notice] = '可加入白金會員' if amount > Order::THRESHOULD[:PLATINUM]
        end
        format.html { render 'index' }
      else
        flash[:errors] = "請重新登入,再執行一次"
        format.html { render 'index' }
      end

      format.json { render json: @cart }
    end
  end


  # GET /carts/1
  # GET /carts/1.json
  def show

    @cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end

  private

  def init_session
    session.delete(:loaded_books)
    session.delete(:load_customer)

  end
end
