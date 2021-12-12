module Users
  class Create
    prepend SimpleCommand

    def initialize(params)
      @params = params
    end

    def call
      user = User.new(@params.except(:password_confirmation))
      user.save unless existing_user.present? || !password_confirmation_valid
      if existing_user.present?
        user.errors.add(:user, "with email address #{@params[:email_address]} already exists")
      end
      if !password_confirmation_valid
        user.errors.add(:password_confirmation, 'doesn\'t match password')
      end
      user
    end

    private

    def password_confirmation_valid
      @params[:password] == @params[:password_confirmation]
    end

    def existing_user
      User.find_by(email_address: @params[:email_address])
    end
  end
end
