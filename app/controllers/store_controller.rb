class StoreController < ApplicationController
  include CurrentCart
  
  skip_before_action :authorize
  before_action :set_cart
  
  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.where(locale: I18n.locale).or(Product.where(locale: nil)).order(:title)
    end
  end
end
