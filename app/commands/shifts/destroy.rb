module Shifts
  class Destroy
    prepend SimpleCommand

    def initialize(id)
      @id = id
    end

    def call
      return nil unless shift.present?
      shift.delete
    end

    private

    def shift
      Shift.find_by(id: @id)
    end
  end
end
