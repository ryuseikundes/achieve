class BlogsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
    @users = User.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.create(blogs_params)
    @blog.user_id = current_user.id

    #  @blog = Blog.new(title:params[:title],content: params[:content], user_id: current_user.id)
    if @blog.save(validate: false)
      redirect_to blogs_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render 'new'
    end
  end


  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if@blog.update(blogs_params)

    redirect_to blog_path, notice:"ブログを編集しました！"

    else
    render 'edit'

    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを消去しました！"


  end

  def show
   @comment = @blog.comments.build
   @comments = @blog.comments
   Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end
end
