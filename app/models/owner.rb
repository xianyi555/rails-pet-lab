class Owner < ActiveRecord::Base
  has_many :pets, dependent: :destroy

  before_save :normalize_phone_number

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

  def normalize_phone_number
    if phone.present?
      phone.gsub!(/^1/, "")
      phone.gsub!(/[()-.]/,"")
    end
  end

end
