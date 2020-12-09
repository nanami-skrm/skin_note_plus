class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :notes, dependent: :destroy
  	has_many :my_items, dependent: :destroy
  	has_many :tweets, dependent: :destroy
  	has_many :empathies, dependent: :destroy
  	has_many :comments, dependent: :destroy
  	has_many :interests, dependent: :destroy
  	has_many :reviews

    validates :name, presence: true, length: { minimum: 2, maximum: 10 }
    validates :age, presence: true
    validates :skin_type, presence: true

    attachment :image

    enum skin_type: { 乾燥肌: 0, 脂性肌: 1, 混合肌: 2, 普通肌: 3 }

    # def todays_items_list(beginning_of_month, end_of_month)
    #   todays_items_list = []
    #   my_notes = self.notes.where(created_at: beginning_of_month.in_time_zone.all_month).includes(:my_items)
    #   self.my_items.each_with_index do |item, index|
    #     (beginning_of_month..end_of_month).each do |date|
    #       note = my_notes.find {|a| a[:date] == date}
    #       if note && note.my_items.find {|a| a[:id] == item.id}
    #         todays_items_list.push({x: date, y: index + 1})
    #       else
    #         todays_items_list.push({x: date, y: nil})
    #       end
    #     end
    #   end
    #   return todays_items_list
    # end

end