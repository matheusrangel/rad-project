class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	def slug_candidates
    [
      :name,
      [:name, :phone],
      [:name, :phone, :email]
    ]
  end

	has_many :contacts

	validates :name, presence: true, length: { minimum: 5, maximum: 40}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

	has_secure_password
	validates :password, presence: true, length: { minimum: 5 }

end
