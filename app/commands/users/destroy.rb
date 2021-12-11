module Users
  class Destroy
    prepend SimpleCommand

    def initialize(id)
      @id = id
    end

    def call
      return nil unless user.present?
      user.delete!
    end

    private

    def user
      User.find_by(id: @id)
    end
  end
end
