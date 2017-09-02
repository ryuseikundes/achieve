class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id )
    # クライアント要求に応じてフォーマットを変更
     respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
          })
        end
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
        })
        format.js { render :index }
        flash[:notice]  = '作成しました！'
      else
        format.html { render :new }
      end
    end
  end

   def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました。' }
      format.js { render :index }
    end
  end

  def edit
     @comment=Comment.find(params[:id])
     @blog = @comment.blog
   end

  def update
     @comment=Comment.find(params[:id])
     if @comment.update(comment_params)
       redirect_to blog_path(@comment.blog), notice: "コメントを更新しました"
     else
       render 'edit'
     end
  end



 private

   def comment_params
     params.require(:comment).permit(:blog_id, :content)
   end
end
