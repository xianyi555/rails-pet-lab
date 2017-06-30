class Owner < ActiveRecord::Base
  # TODO: add association to pets

  # TODO: add association to appointments (through pets)

  # TODO: add validations
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :email, format: { with: /@/, message: "must include @" }

  before_save :normalize_phone_number

  # removes leading 1 and the characters (, ), -, .
  def normalize_phone_number
    # stretch
    if phone.present?
      phone.gsub!(/^1/, "")
      phone.gsub!(/[()-.]/,"")
    end
  end

end
