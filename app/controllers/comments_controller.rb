class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id]) # プロトタイプを取得する
    @comment = @prototype.comments.build(comment_params)
    @comment.user = current_user 
        
    if @comment.save
      redirect_to prototype_path(@prototype) # 今回の実装には関係ありませんが、このようにPrefixでパスを指定することが望ましいです。
    else
      render "prototypes/show" # views/tweets/show.html.erbのファイルを参照しています。
    end
   end

  

  
  
     private

    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end
end
