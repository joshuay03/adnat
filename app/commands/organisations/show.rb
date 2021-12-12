module Organisations
  class Show
    prepend SimpleCommand

    def initialize(id)
      @id = id
    end

    def call
      return nil unless organisation.present?
      organisation
    end

    private

    def organisation
      Organisation.find_by(id: @id)
    end
  end
end
