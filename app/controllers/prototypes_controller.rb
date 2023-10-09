class PrototypesController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
     @prototype = Prototype.new(prototype_params)
    if @prototype.save
     redirect_to root_path, notice: 'Prototype was successfully created.'
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
  end


  def edit
    @prototype = Prototype.find(params[:id]) 
    if current_user != @prototype.user
      redirect_to root_path
   end
  end
  
  def update
     @prototype = Prototype.find(params[:id])
      if  @prototype.update(prototype_params) 
          redirect_to prototype_path(@prototype) #詳細ページへ飛ぶ
      else
        render :edit
      end
     end


  def destroy
    # セッションを削除することでログアウトを実現
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path # トップ画面にリダイレクト
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :image, :concept).merge(user_id: current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    # 必要に応じてユーザーパラメータを設定してください
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? 
      redirect_to action: :index
    end
  end
end


