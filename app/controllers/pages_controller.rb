class PagesController < ApplicationController
  def index
    @posts = Post.limit(16)
  end
end
