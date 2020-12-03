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

    validates :name, presence: true
    validates :age, presence: true

    attachment :image

    enum skin_type: { 乾燥肌: 0, 脂性肌: 1, 混合肌: 2, 普通肌: 3 }

end
