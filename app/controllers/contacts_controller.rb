class ContactsController < ApplicationController
	def new
		@contact=Contact.new
	end

	def create
		@contact=Contact.create(contact_params)
		if @contact.save
			name=params[:contact][:photo].original_filename
			directory="public/data"
			path=File.join(directory,name)
			File.open(path, "wb") { |f| f.write(params[:contact][:photo].read) }
			@contact1=Contact.find(@contact.id)
			@contact1.update(:image_location => name)
			redirect_to @contact
		else
			render 'new'
		end
	end

	def show
		@contact=Contact.find(params[:id])
	end

	def index
		@contacts=Contact.all
	end

	def destroy
		@contact=Contact.find(params[:id])
		@contact.destroy
		redirect_to contacts_path
	end

	def edit
		@contact=Contact.find(params[:id])
	end

	def update
		@contact=Contact.find(params[:id])
		if @contact.update(contact_params)
			redirect_to contacts_path
		else
			render 'edit'
		end
	end

	def contact_params
		params.require(:contact).permit(:firstname,:lastname,:email,:mobile,:address)
	end
end
