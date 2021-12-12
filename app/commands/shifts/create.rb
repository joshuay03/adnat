module Shifts
  class Create
    prepend SimpleCommand

    def initialize(organisation_id, user_id, params)
      @organisation_id = organisation_id
      @user_id = user_id
      @params = params
    end

    def call
      shift = Shift.new(
        @params.merge(
          organisation_id: @organisation_id
        ).merge(
          user_id: @user_id
        )
      )
      shift.save
      shift
    end

    private
  end
end
