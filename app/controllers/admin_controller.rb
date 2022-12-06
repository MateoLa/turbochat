class AdminController < ApplicationController

  def index
    @messages = Message.messages_this_month
  end

  def rooms
    @rooms = Room.all
  end


  def messages
    @messages = Message.all.includes(:user)
  end

  def users; end


  def show_post
    @post = Post.includes(:user, comments: [:user, :rich_text_body]).find(params[:id])
  end
end
