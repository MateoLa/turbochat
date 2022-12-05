class AdminController < ApplicationController
  def dashboard
    if current_user&.admin?
      @messages = Message.messages_this_month
    else
      redirect_to root_path
    end
  end

  def index; end


  def posts
    @posts = Post.all.includes(:user)
  end


  def comments; end

  def users; end


  def show_post
    @post = Post.includes(:user, comments: [:user, :rich_text_body]).find(params[:id])
  end
end
