class MapsController < ApplicationController
  def index
    @posts = Post.all
  end
end
