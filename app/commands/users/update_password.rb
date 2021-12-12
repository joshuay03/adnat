module Users
  class UpdatePassword
    prepend SimpleCommand

    def initialize(params)
      @params = params
    end

    def call
      user = existing_user
      user.update(password: @params[:password]) unless !user.present? || !password_confirmation_valid
      if !user.present?
        user = User.new
        user.errors.add(:user, "with email address #{@params[:email_address]} doesn't exists")
      end
      if !password_confirmation_valid
        user.errors.add(:password_confirmation, 'doesn\'t match password')
      end
      user
    end

    private

    # Check if password confirmation matches password
    def password_confirmation_valid
      @params[:password] == @params[:password_confirmation]
    end

    def existing_user
      User.find_by(email_address: @params[:email_address])
    end
  end
end
