# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = current_user.posts.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)

    # storing the Cloudinary link in the post image field
    unless params[:post][:photo].blank?
      @post[:photo] = upload_post_image(params)['secure_url']
    end

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      flash.now[:error] = I18n.t(:form_has_errors, scope: 'errors.messages')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)

      # updating the Cloudinary link in the post image field
      unless params[:post][:photo].blank?
        @post.update(photo: upload_post_image(params)['secure_url'])
      end
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      flash.now[:error] = I18n.t(:form_has_errors, scope: 'errors.messages')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def feeds
    @posts = current_user.feed.paginate(page: params[:page], per_page: 5)
  end

  private

  def upload_post_image(params)
    Cloudinary::Uploader.upload(params[:post][:photo],
                                folder: 'fake_twitter',
                                transformation: { width: 500, height: 500,
                                                  crop: 'fill' })
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:user_id, :description, :photo)
  end
end
