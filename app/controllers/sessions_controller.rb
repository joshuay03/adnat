class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    command = command_class::Create.call(create_params)
    @user = command.result
    if command.success? && @user.present?
      if @user.errors.empty?
        log_in @user
        redirect_to @user
      else
        render 'new'
      end
    else
      new
      render 'new'
    end
  end

  private

  def command_class
    ::Sessions
  end

  def create_params
    params.require(:session).permit(:email_address, :password)
  end
end
