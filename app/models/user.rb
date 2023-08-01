class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
  format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "must be a valid email address" }
  validates :username, presence: true, uniqueness: true,
  length: { in: 3..15 }, format: { with: /\A[a-zA-Z0-9]+\Z/, message: "only allows letters and numbers" }
  validates :password, length: { minimum: 6}

  has_many :products, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save :downcase_attributes

  private

  def downcase_attributes
    self.username = username.downcase
    self.email = email.downcase
  end
end
