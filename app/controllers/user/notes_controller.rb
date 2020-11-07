class User::NotesController < ApplicationController

	def index
		@beginning_of_month = Date.new(params[:year].to_i, params[:month].to_i, 1)
		@end_of_month = Date.new(params[:year].to_i, params[:month].to_i, -1)
		@notes = current_user.notes.where(date: @beginning_of_month..@end_of_month)
	
		# {"悪い"=>13, "少し悪い"=>3, "普通"=>4, "良い"=>4, "とても良い"=>2}
		grouping_conditions_count = @notes.group(:condition).count


		@excellent_condition_count = grouping_conditions_count["とても良い"]
		@good_condition_count = grouping_conditions_count["良い"]
		@average_condition_count = grouping_conditions_count["普通"]
		@poor_condition_count = grouping_conditions_count["少し悪い"]
		@bad_condition_count = grouping_conditions_count["悪い"]

		# @condition_list = (@beginning_of_month..@end_of_month).map do |date|
  # 		{ x: date, y: @notes.find_by(date: date)&.read_attribute_before_type_cast(:condition) || 2 }
  #   	end
	 #    # ↑投稿がなかった日の肌のコンディションを「2:普通」にする

	 #    @todays_items_list = []
		# current_user.my_items.pluck(:id).each do |my_item_id|
		# 	(@beginning_of_month..@end_of_month).each do |date|
		# 		@todays_items_list.push({ x: date, y: TodaysItem.joins(:note, :my_item).where(my_items: { user_id: current_user.id }, my_item_id: my_item_id).where('notes.date = ?', date).first&.my_item_id })
		# 	end #.pushは()内の要素を配列の末尾に追加する .joinsは複数のテーブルにまたがるレコードを条件の一致するものだけくっつける
		# end
	end

	def new
		@note = Note.new
		@my_items = MyItem.where(user_id: current_user.id)
		@note.todays_items.build
	end

	def create
		params[:note][:user_id] = current_user.id
		# ↑note_paramsで値が決定されるの前に書く
		note = Note.new(note_params)
		# if Note.find_by(date: params[:date], user_id: current_user.id)
		# 	existing_note = Note.find_by(date: params[:date], user_id: current_user.id)
		# 	existing_note.condition = note.condition
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
	end

	def todays_item_params
    params.require(:todays_items).permit(my_item_id: [])
	end
end
