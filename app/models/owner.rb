class Owner < ActiveRecord::Base
  # TODO: add association to pets
  has_many :pets
  # TODO: add validations

  before_save :normalize_phone_number

  # removes leading 1 and the characters (, ), -, .
  def normalize_phone_number
    # stretch
  end

end
