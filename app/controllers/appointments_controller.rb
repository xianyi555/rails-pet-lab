class AppointmentsController < ApplicationController

  # TODO: add new action to show new appointment form
  def new
    pet_id = params[:pet_id]
    @pet = Pet.find_by(id: pet_id)
    @appointment = Appointment.new
  end

  # TODO: add create action to store new appointment in db
  def create
    pet_id = params[:pet_id]
    pet = Pet.find_by(id: pet_id)
    new_appointment = Appointment.new(appointment_params)
    if new_appointment.save
      pet.appointments << new_appointment
      redirect_to pet_path(pet)
    else
      # TODO: handle save errors and communicate issues to user
      render :new
    end
  end

  # TODO: implement strong parameters
  private
    def appointment_params
      params.require(:appointment).permit(:veterinarian, :reason, :time)
    end
end
