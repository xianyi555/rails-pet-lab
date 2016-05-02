class Owner < ActiveRecord::Base
  has_many :pets, dependent: :destroy

  validates :first_name,
            presence:   true,
            length:   { maximum: 255 }

  validates :last_name,
            presence:   true,
            length:   { maximum: 255 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: true,
            length:     { maximum: 255 }

end
