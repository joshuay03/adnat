module Organisations
  class Update
    prepend SimpleCommand

    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      return nil unless organisation.present?
      organisation.update!(@params)
    end

    private

    def organisation
      Organisation.find_by(id: @id)
    end
  end
end
