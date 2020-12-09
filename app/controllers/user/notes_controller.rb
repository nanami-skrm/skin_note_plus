class User::NotesController < ApplicationController

	before_action :authenticate_user!

	def index
		unless params[:year].present? or params[:month].present?
		  params[:year] = params["date(1i)"]
		  params[:month] = params["date(2i)"]
		end
		@beginning_of_month = Date.new(params[:year].to_i, params[:month].to_i, 1)
		@end_of_month = Date.new(params[:year].to_i, params[:month].to_i, -1)
		@notes = current_user.notes.where(date: @beginning_of_month..@end_of_month)
		@selected = Date.parse("#{params[:year]}/#{params[:month]}")

		#ドーナツグラフ-------------------------------------------------------------------------------------------
		@grouping_conditions_count = @notes.group(:condition).count

		#折れ線グラフ-------------------------------------------------------------------------------------------
		@condition_list = (@beginning_of_month..@end_of_month).map do |date|
  		{ x: date, y: @notes.find_by(date: date)&.read_attribute_before_type_cast(:condition) || 2 }
    end # ↑投稿がなかった日の肌のコンディションを「2:普通」にする

    #横棒グラフ--------------------------------------------------------------------------------------------
		my_item_lists_label = {}
    current_user.my_items.pluck(:item_name).each_with_index{|item, index| my_item_lists_label.store(index + 1, item)}
    @my_item_lists_label = my_item_lists_label.to_json

    @todays_items_list = []
    my_notes = current_user.notes.where(date: @beginning_of_month.in_time_zone.all_month).includes(:my_items)
    current_user.my_items.each_with_index do |item, index|
      (@beginning_of_month..@end_of_month).each do |date|
        note = my_notes.find {|a| a[:date] == date}
        if note && note.my_items.find {|a| a[:id] == item.id}
          @todays_items_list.push({x: date, y: index + 1})
        else
          @todays_items_list.push({x: date, y: nil})
        end
      end
    end

    # @todays_item_list = current_user.todays_items_list(@beginning_of_month, @end_of_month)

    #---------------------------------------------------------------------------------------------------
	end

	def new
		@note = Note.new
		@my_items = MyItem.where(user_id: current_user.id)
		@note.todays_items.build
	end

	def create
		params[:note][:user_id] = current_user.id # ←note_paramsで値が決定されるの前に書く
		date = params[:note][:date]

		if Note.find_by(date: date, user_id: current_user.id) # ←新規だった場合はここを無視する
			old_note = Note.find_by(date: date, user_id: current_user.id)
			old_note_ids = old_note.id
		end

		if old_note.present? # ←もし以前に登録したことがある日付だったら
			if old_note.update(note_params)
			# ここからTodaysItemのupdate--------------------------------------------------------------------------------
				my_item_old_ids = TodaysItem.where(note_id: old_note_ids).pluck('my_item_id') # ←以前同じ日付に登録したTodaysItemのmy_item_idを取得
				my_item_new_ids = todays_item_params[:my_item_id] # ←今登録されたTodaysItemのidを取得
				if my_item_old_ids.blank? #　←もし前の投稿ではTodayItemを選択していなかったら
					my_item_new_ids.each do | id |
						TodaysItem.create(note_id: old_note.id, my_item_id: id)
					end
				elsif (my_item_old_ids - my_item_new_ids).size != 0 # ←もし前の投稿のTodayItemと違いがあったら([1,2,3]-[2,3]=[1])
			    (my_item_old_ids - my_item_new_ids).each do | id | # ←今登録したTodaysItemになかったものを削除する
			    	TodaysItem.find_by(note_id: old_note.id, my_item_id: id).delete
			    end
			    (my_item_new_ids - my_item_old_ids).each do | id | # ←以前登録したTodaysItemになかったものを登録する
						TodaysItem.create(note_id: old_note.id, my_item_id: id)
					end
			# ここまでTodaysItemのupdate---------------------------------------------------------------------------------
				end
				redirect_to user_notes_path(year: Time.now.year, month: Time.now.month)
			else
				@my_items = MyItem.where(user_id: current_user.id)
				render "new"
			end

		else # ←はじめて登録する日付だったら
			@note = Note.new(note_params)
			if @note.save
				todays_item_params[:my_item_id].each do |my_item_id|
					TodaysItem.create(note_id: note.id, my_item_id: my_item_id)
				end
				redirect_to user_notes_path(year: Time.now.year, month: Time.now.month)
			else
				@my_items = MyItem.where(user_id: current_user.id)
				render "new"
			end
	   end
	end

	private

	def note_params
		params.require(:note).permit(:user_id, :date, :condition)
	end

	def todays_item_params
		if params[:todays_items].present?
			params.require(:todays_items).permit(my_item_id: [])
		else
			{:my_item_id => []}	# ←使用したアイテムを選択していなくても保存できるように空の配列渡す
		end
	end


end
