class FavoritesController < ApplicationController

  before_filter :check_login

  def index
    @favs = Favorite.find( :all, :order => 'name ASC' );
  end
 
  def add
    fav = Favorite.new(params['favorite'])

    if !fav.save
      render :text => "<font color=\"red\">NOT SAVED!</font>"
    else
      render :text => "<li><a href=\"" + fav.link + "\">" + fav.name + "</a>"
    end


  end
end
