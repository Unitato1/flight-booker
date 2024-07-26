class BookingsController < ApplicationController
  def new
    @booking_params = booking_params
    @flight = Flight.find(@booking_params[:flight_id])
    @booking = Booking.new
    @passengers = Array.new(@booking_params[:passangers].to_i) { Passenger.new }
  end

  def create
    @booking = Booking.new(flight_id: booking_params[:flight_id])
    booking_params[:passengers_attributes].each do |_, values|
      @booking_passenger = @booking.passengers.build(values)
      @booking_passenger.save
    end
    if @booking.save then
      redirect_to @booking
    else
      render :new, status: :unprocessed_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @booking_passengers = @booking.passengers
    @flight = @booking.flight
  end
  private
  def booking_params
    params.require(:booking).permit(:flight_id, :passangers, passengers_attributes: [:name, :email])
  end
end
