class FlightsController < ApplicationController
  def index
    @airports = Airport.all.map { |airport| [airport.code, airport.id]}
    @flight = Flight.new
    @flights = Flight.order(:start)
    if params[:flight].present?
      @seach_params = flight_params
      @flights = @flights.where(arrival_airport_id: @seach_params[:arrival_airport_id]) unless @seach_params[:arrival_airport_id] == ""
      @flights = @flights.where(departure_airport_id: @seach_params[:departure_airport_id]) unless @seach_params[:departure_airport_id] == ""
      @flights = @flights.where("Date(start) = ?", @seach_params[:start]) if @seach_params[:start].present?
      @flight_arrival_airport_id = @seach_params[:arrival_airport_id]
    end
    @flight_starts = @flights.map { |flight| [flight.start.strftime("%d/%m/%Y"), flight.start]}
  end

  def new
    @flight = Flight.new
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def create
  end
  private
  def flight_params
    params.require(:flight).permit(:arrival_airport_id, :departure_airport_id, :passangers, :start)
  end
end
