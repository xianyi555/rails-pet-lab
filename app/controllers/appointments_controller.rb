class AppointmentsController < ApplicationController
  def new
    pet_id = params[:pet_id]
    @pet = Pet.find_by(id: pet_id)
    @appointment = Appointment.new
  end
end
