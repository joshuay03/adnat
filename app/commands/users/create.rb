module Users
  class Create
    prepend SimpleCommand

    def initialize(params)
      @params = params
    end

    def call
      user = User.new(@params.except(:password_confirmation))
      user.save unless !password_confirmation_valid
      user.errors.full_messages.push('Password confirmation doesn\'t match password')
      user
    end

    private

    def password_confirmation_valid
      @params[:password] == @params[:password_confirmation]
    end
  end
end
