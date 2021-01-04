class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :original_password_matches, on: :update
  has_secure_password

  attr_accessor :original_password

  after_destroy :ensure_an_admin_remains

  class Error < StandardError; end

  private
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end

  # TODO This doesn't work - the new password has already been assigned
  # to the model field, so when comparing the digest with the original password,
  # it'll claim the original password is incorrect (since the digest has already been updated).
  def original_password_matches
    return unless defined?(original_password)
    if BCrypt::Password.new(password_digest) != original_password
      errors.add(:original_password, "must match existing password")
    end
  end
end
