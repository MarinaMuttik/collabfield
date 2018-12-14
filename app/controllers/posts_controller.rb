# frozen_string_literal: true

# Establishing controls for posts and routes


class PostsController < ApplicationController
  # index show new edit create update destroy
  before_action :redirect_if_not_signed_in, only: [:new, :edit, :destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      @branch = params['post']['branch']
      @categories = Category.where(branch: @branch)
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    # redirect_branch = @post.branch
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_for_branch(params[@post.branch])
  end

  def hobby
    posts_for_branch(params[:action])
  end

  def study
    posts_for_branch(params[:action])
  end

  def team
    posts_for_branch(params[:action])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
                         .merge(user_id: current_user.id)
  end

  def get_posts
    PostsForBranchService.new({
      branch: params[:action],
      search: params[:search],
      category: params[:category]
      }).call
    end

  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = get_posts.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.js { render partial: 'posts/posts_pagination_page' }
    end
  end
end
