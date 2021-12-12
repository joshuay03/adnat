class UsersController < ApplicationController
  def index
    command = command_class::Index.call
    @users = command.result
    if command.success?
      render json: command.result,
             root: 'data',
             status: :ok,
             each_serializer: serializer_class::IndexSerializer
    else
      render json: command.errors.to_h, status: :unprocessable_entity
    end
  end

  def show
    command = command_class::Show.call(params[:id])
    @user = command.result
    if command.success? && @user.present? && @user == current_user
      render 'show'
    else
      new
      render 'sessions/new'
    end
  end

  def new
    @user = User.new
    @target = @user
  end

  def create
    command = command_class::Create.call(create_params)
    @user = command.result
    if command.success? && @user.errors.empty?
      new
      render 'new'
    else
      @target = @user
      render 'new'
    end
  end

  def edit
    @target = current_user
    render 'update'
  end

  def update
    command = command_class::Update.call(params[:id], update_params)
    if command.success? && command.result.present?
      redirect_to current_user
    else
      render 'update'
    end
  end

  # Change the users password
  def edit_password
    new
    render 'update_password'
  end

  def update_password
    command = command_class::UpdatePassword.call(update_password_params)
    @user = command.result
    binding.pry
    if command.success? && @user.errors.empty?
      new
      render 'sessions/new'
    else
      @target = @user
      render 'update_password'
    end
  end

  def destroy
    command = command_class::Destroy.call(params[:id])
    if command.success? && command.result.present?
      if command.errors.empty?
        render json: 'User deleted successfully',
               status: :ok
      else
        render json: command.errors.to_h, status: :unprocessable_entity
      end
    else
      render json: 'User not found', status: :not_found
    end
  end

  private

  def command_class
    ::Users
  end

  def serializer_class
    ::Users
  end

  def create_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :email_address)
  end

  def update_password_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
