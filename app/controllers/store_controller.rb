class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)

    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1

    @counter = session[:counter]
  end
end
