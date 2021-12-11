module Users
  class Index
    prepend SimpleCommand

    def initialize
    end

    def call
      User.all
    end
  end
end
