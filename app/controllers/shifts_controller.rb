class ShiftsController < ApplicationController
    def new
      @shift = Shift.new
      organisation
      @target = @shift
    end

    def create
      command = command_class::Create.call(params[:organisation_id], current_user.id, create_params)
      @shift = command.result
      organisation
      if command.success? && @shift.errors.empty?
        render 'organisations/show', id: organisation.id
      else
        @target = @shift
        render 'new'
      end
    end

    def edit
      shift
      organisation
      render 'update'
    end

    def update
      command = command_class::Update.call(params[:id], update_params)
      if command.success? && command.result.present?
        render 'organisations/show', id: organisation.id
      else
        render 'update'
      end
    end

    def destroy
      organisation
      command = command_class::Destroy.call(params[:id])
      if command.success?
        render 'organisations/show', id: @organisation_id
      end
    end

    private

    def command_class
      ::Shifts
    end

    def create_params
      params.require(:shift).permit(:start, :finish, :break_length)
    end

    def update_params
      params.require(:shift).permit(:start, :finish, :break_length)
    end

    def shift
      @shift ||= Shift.find_by(id: params[:id])
    end

    def organisation
      if params[:organisation_id].present?
        @organisation ||= Organisation.find_by(id: params[:organisation_id])
      else
        organisation_id = Shift.find_by(id: params[:id]).organisation_id
        @organisation ||= Organisation.find_by(id: organisation_id)
      end
    end
end
