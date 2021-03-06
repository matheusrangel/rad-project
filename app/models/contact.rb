class Contact < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  acts_as_paranoid

  def slug_candidates
    [
      :nome,
      [:nome, :phone],
      [:nome, :phone, :address]
    ]
  end

  belongs_to :user

  validates :nome, presence: true, length: { minimum: 5, maximum: 40}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
	validates :address, length: { maximum: 255 }
end
