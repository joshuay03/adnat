module Shifts
  class Update
    prepend SimpleCommand

    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      return nil unless shift.present?
      shift.update(@params)
    end

    private

    def shift
      Shift.find_by(id: @id)
    end
  end
end
