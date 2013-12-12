# encoding: utf-8
class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  require 'date'
  require 'pry'
  def index

    @orders = Order.paginate(:page => params[:page],
                             :per_page => 30,
                             :order => 'updated_at DESC')

    # @orders = Order.all

    # 1week = Order.orders_sum(Order.recent_one_week_orders)
    # binding.pry

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  
  def show_by_date
    
    branch_name = params[:order][:branch_name]
    branch = Branch.find_by_name(branch_name).id
    order_date = Date.strptime(params[:order][:date], "%m/%d/%Y").midnight
    @orders = Order.by_day_branch(order_date, branch )


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end

  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end