class ContactsController < ApplicationController
	before_action :logged_in_user
	before_action :set_contact, only: [:show, :edit, :update, :destroy]

	def index
		@contacts = current_user.contacts
		respond_to do |format|
			format.html { render :index => @contacts = @contacts.paginate(:page => params[:page], :per_page => 6) }
			format.xml { render :xml => @contacts.to_xml }
			format.json { render :json => @contacts.to_json }
		end
	end

	def show
	end

	def new
		@contact = current_user.contacts.build
	end

	def create
		@contact = current_user.contacts.build(contact_params)
		if @contact.save
			redirect_to contacts_path, flash: { success: 'Contato cadastrado com sucesso!' }
		else
			render 'new'
		end
	end

	def update
  	if @contact.update(contact_params)
  		redirect_to contacts_path, flash: { success: 'Contato atualizado com sucesso!' }
    else
      render 'edit'
    end
  end

	def destroy
  	@contact.destroy
		respond_to do |format|
			format.html { redirect_to contacts_path, flash: { success: 'Contato removido com sucesso!' } }
			format.js { flash.now[:notice] = 'Contato removido com sucesso!' }
		end

  end

	 # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        redirect_to login_url, flash: { danger: 'Por favor, faça login' }
      end
    end

	private
		def set_contact
      @contact = current_user.contacts.friendly.find(params[:id])
    end

		# Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:nome, :email, :phone, :address)
    end

end
