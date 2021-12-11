module Users
  class Show
    prepend SimpleCommand

    def initialize(id)
      @id = id
    end

    def call
      return nil unless user.present?
      user
    end

    private

    def user
      User.find_by(id: @id)
    end
  end
end
