class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true
  validate :validate_single_user, on: :create

  before_save { email.downcase! }

  def self.first_access?
    count == 0
  end

  def validate_single_user
    errors.add(:id, "only one user is allowed") unless User.first_access?
  end
end
