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

    def destroy
      @organisation_id = Shift.find_by(id: params[:id]).organisation_id
      command = command_class::Destroy.call(params[:id])
      if command.success?
        organisation
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

    def organisation
      if params[:organisation_id].present?
        @organisation ||= Organisation.find_by(id: params[:organisation_id])
      else
        @organisation ||= Organisation.find_by(id: @organisation_id)
      end
    end
end
