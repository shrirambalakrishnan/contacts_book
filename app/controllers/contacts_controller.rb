class ContactsController < ApplicationController
	$flag_edit=false # flag to find whether the request for photo upload is for new or edit
	def new
		@contact=Contact.new
		$flag_edit=false
	end

	def create
		@contact=Contact.create(contact_params)
		@name=savePhoto
		@contact.image_location=@name
		@contact.userid=session[:id]
		if @contact.save
			redirect_to @contact
		else
			render 'new'
		end
	end

	def show
		@contact=Contact.find(params[:id])
	end

	def index
		@contacts=Contact.where("userid=?", session[:id])
		#byebug
	end

	def destroy
		@contact=Contact.find(params[:id])
		@contact.destroy
		redirect_to contacts_path
	end

	def edit
		@contact=Contact.find(params[:id])
		$flag_edit=true
	end

	def update
		name=savePhoto
		@contact=Contact.find(params[:id])
		@contact.image_location=name
		$flag_edit=false
		if @contact.update(contact_params)
			redirect_to contacts_path
		else
			render 'edit'
		end
	end
	
	def savePhoto
		if !$flag_edit
			name=params[:contact][:photo].original_filename
			directory="public/data"
			path=File.join(directory,name)
			File.open(path, "wb") { |f| f.write(params[:contact][:photo].read) }
			return name
		else
			@contact=Contact.find(params[:id])
			name=@contact.image_location
			File.delete("#{Rails.root}/public/data/#{name}")
			name=params[:contact][:photo].original_filename
			directory="public/data"
			path=File.join(directory,name)
			File.open(path, "wb") { |f| f.write(params[:contact][:photo].read) }
			return name
		end
	end

	def contact_params
		params.require(:contact).permit(:firstname,:lastname,:email,:mobile,:address)
	end
end
