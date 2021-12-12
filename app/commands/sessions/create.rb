module Sessions
  class Create
    prepend SimpleCommand

    def initialize(params)
      @params = params
    end

    def call
      return nil unless user.present?
      user.authenticate(@params[:password])
    end

    private

    def user
      user = User.find_by(email_address: @params[:email_address])
    end
  end
end
