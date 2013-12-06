# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_cart
    Cart.find(session[:cart_id])
    rescue ActionController::RecordNotFound
        puts "cart not found\n"*50
        cart = Cart.create
        session[:cart_id] = cart_id
        return cart      
  end

    rescue_from CanCan::AccessDenied do |exception|
    msg = '權限不足,請登入'
    flash.keep[:error] = msg
    # binding.pry
    # redirect_to main_app.root_url, :alert => exception.message
    redirect_to root_url
    end

end
