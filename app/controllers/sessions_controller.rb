class SessionsController < ApplicationController
  def new
    if current_user.present?
      @user = current_user
      redirect_to @user
    else
      @user = User.new
      @target = @user
      render 'new'
    end
  end

  def create
    command = command_class::Create.call(create_params)
    @user = command.result
    if command.success? && @user.present? && @user.errors.empty?
      log_in @user
      redirect_to @user
    else
      @user = User.new
      @target = @user
      render 'new'
    end
  end

  def destroy
    log_out @user
    @user = User.new
    @target = @user
    render 'new'
  end

  private

  def command_class
    ::Sessions
  end

  def create_params
    params.require(:session).permit(:email_address, :password)
  end
end
