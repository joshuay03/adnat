module Organisations
  class Create
    prepend SimpleCommand

    def initialize(params)
      @params = params
    end

    def call
      organisation = Organisation.new(@params)
      organisation.save unless existing_organisation.present?
      if existing_organisation.present?
        organisation.errors.add(:organisation, "name #{@params[:name]} already exists")
      end
      organisation
    end

    private

    def existing_organisation
      Organisation.find_by(name: @params[:name])
    end
  end
end
