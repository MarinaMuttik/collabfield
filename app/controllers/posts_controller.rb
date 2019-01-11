# frozen_string_literal: true

# Establishing controls for posts and routes


class PostsController < ApplicationController
  # index show new edit create update destroy
  before_action :redirect_if_not_signed_in, only: [:new, :edit, :destroy]

  def show
    @post = Post.find(params[:id])
    @branch = Category.find(@post.category_id).branch
    if user_signed_in?
      @message_has_been_sent = conversation_exist?
    end
  end

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    @branch = Category.find(@post.category_id).branch
    @categories = Category.where(branch: @branch)
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
    @post = Post.find(params[:id])
    @post.destroy

    render 'deleted'
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

  def conversation_exist?
    Private::Conversation.between_users(current_user.id, @post.user.id).present?
  end
end
