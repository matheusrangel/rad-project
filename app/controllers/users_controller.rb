class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			redirect_to @user, flash: { success: 'Cadastro efetuado com sucesso!' }
		else
			render 'new'
		end
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email, :phone)
    end

     # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        redirect_to login_url, flash: { danger: 'Por favor, faça login' }
      end
    end

end
