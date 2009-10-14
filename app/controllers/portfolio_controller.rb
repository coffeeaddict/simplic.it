class PortfolioController < ApplicationController

  before_filter :assign_language

  def index
    @portfolio = Portfolio.find :all;
    
    super
  end


end
