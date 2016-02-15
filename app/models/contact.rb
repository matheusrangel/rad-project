class Contact < ActiveRecord::Base
  belongs_to :user
  scope :joao, -> { where("nome like 'João%'") }

  validates :nome, presence: true, length: { minimum: 5, maximum: 40}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
	validates :address, length: { maximum: 255 }
end
