module Users
  class Update
    prepend SimpleCommand

    def initialize(id, params)
      @id = id
      @params = params
    end

    def call
      return nil unless user.present?
      user.update(@params)
    end

    private

    def user
      User.find_by(id: @id)
    end
  end
end
