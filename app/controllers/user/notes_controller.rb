class User::NotesController < ApplicationController

	def index
		@beginning_of_month = Date.new(params[:year].to_i, params[:month].to_i, 1)
		@end_of_month = Date.new(params[:year].to_i, params[:month].to_i, -1)
		@notes = current_user.notes.where(date: @beginning_of_month..@end_of_month)
		@good_condition_count = current_user.notes.where(date: @beginning_of_month..@end_of_month, condition: 3).count
		@average_condition_count = current_user.notes.where(date: @beginning_of_month..@end_of_month, condition: 2).count
		@poor_condition_count = current_user.notes.where(date: @beginning_of_month..@end_of_month, condition: 1).count
		@bad_condition_count = current_user.notes.where(date: @beginning_of_month..@end_of_month, condition: 0).count

		@condition_list = (@beginning_of_month..@end_of_month).map do |date|
            { x: date, y: @notes.find_by(date: date)&.read_attribute_before_type_cast(:condition) || 2 }
        end
        @condition_list = (@beginning_of_month..@end_of_month).map do |date|
            { x: date, y: @notes.find_by(date: date)&.read_attribute_before_type_cast(:condition) }
        end
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
			redirect_to user_notes_path(year: Time.now.year, month: Time.now.month)
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
