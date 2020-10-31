class User::NotesController < ApplicationController

	def index
	end

	def new
		@note = Note.new
		@my_items = MyItem.where(user_id: current_user.id)
		@note.todays_items.build
	end

	def create
		params[:note][:user_id] = current_user.id
		note = Note.new(note_params)
		if note.save
			todays_item_params[:my_item_id].each do |my_item_id|
				TodaysItem.create(note_id: note.id, my_item_id: my_item_id)
			end
			redirect_to user_notes_path
		else
			@my_items = MyItem.where(user_id: current_user.id)
			render "new"
		end
	end

	def note_params
		params.require(:note).permit(:user_id, :date, :condition)
		#params.require(:note).permit(:user_id, :date, :condition, my_item_id: [])
	end

	def todays_item_params
        params.require(:todays_items).permit(my_item_id: [])
	end
end
