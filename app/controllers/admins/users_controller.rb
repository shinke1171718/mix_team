class Admins::UsersController < Admins::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.ordered_position.page(params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admins_user_path(@user), notice: 'ユーザーが登録されました。'
    else
      flash[:alert] = "登録に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_user_path(@user), notice: 'ユーザーが更新されました。'
    else
      flash[:alert] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admins_users_path, notice: 'ユーザーが削除されました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :position, :department_id, :state)
  end
end
