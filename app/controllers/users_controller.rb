class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
    
    # ユーザー情報を変数に代入する
    @name = @user.name
    @profile = @user.profile
    @occupation = @user.occupation
    @position = @user.position
  
  end


  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: 'User information was successfully updated.'
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # 必要に応じてユーザーパラメータを設定してください
  end

end