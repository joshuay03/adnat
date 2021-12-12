module Organisations
  class Create
    prepend SimpleCommand

    def initialize(params)
      @params = params
    end

    def call
      organisation = Organisation.new(@params)
      if existing_organisation.present?
        organisation.errors.add(:organisation, "name #{@params[:name]} already exists")
      else
        organisation.save
        organisation
      end
    end

    private

    def existing_organisation
      Organisation.find_by(name: @params[:name])
    end
  end
end
