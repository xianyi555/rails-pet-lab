class Appointment < ApplicationRecord
  belongs_to :pet, optional: true
end
