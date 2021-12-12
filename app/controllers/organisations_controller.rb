class OrganisationsController < ApplicationController
  def show
    command = command_class::Show.call(params[:id])
    @organisation = command.result
    if command.success? && @organisation.present?
      render 'show'
    else
      new
      render 'new'
    end
  end

  def new
    @organisation = Organisation.new
    @target = @organisation
  end

  def create
    command = command_class::Create.call(create_params)
    @organisation = command.result
    if command.success? && @organisation.errors.empty?
      redirect_to current_user
    else
      @target = @organisation
      render 'new'
    end
  end

  def edit
    organisation
    render 'update'
  end

  def update
    command = command_class::Update.call(params[:id], update_params)
    @organisation = command.result
    if command.success? && @organisation.present?
      redirect_to current_user
    else
      render "edit_organisation/#{params[:id]}"
    end
  end

  # Add a user to the organisation
  def join
    current_user.update(organisation_id: params[:id])
    redirect_to current_user
  end

  # Remove a user to the organisation
  def leave
    current_user.update(organisation_id: nil)
    redirect_to current_user
  end

  private

  def command_class
    ::Organisations
  end

  def create_params
    params.require(:organisation).permit(:name, :hourly_rate)
  end

  def update_params
    params.require(:organisation).permit(:id, :name, :hourly_rate)
  end

  def organisation
    @organisation ||= Organisation.find_by(id: params[:id])
  end
end
