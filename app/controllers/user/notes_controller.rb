class User::NotesController < ApplicationController

	def index
	end

	def new
		@note = Note.new
		@my_items = MyItem.where(user_id: current_user.id)
	end

	def create
	end
end
