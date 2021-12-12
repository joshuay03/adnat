class ShiftsController < ApplicationController
    def new
      @shift = Shift.new
      @organisation = organisation
      @target = @shift
    end

    def create
      command = command_class::Create.call(params[:organisation_id], current_user.id, create_params)
      @shift = command.result
      @organisation = organisation
      if command.success? && @shift.errors.empty?
        redirect_to current_user
      else
        @target = @shift
        render 'new'
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
      Organisation.find_by(id: params[:organisation_id])
    end
end
