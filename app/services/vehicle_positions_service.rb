class VehiclePositionsService
  attr_reader :stop, :response

  def initialize stop
    @stop = stop
    url = HTTParty.get("http://realtime.ripta.com:81/api/vehiclepositions?format=json")
    @response = JSON.parse(url.body)["entity"]
  end

  def sorted_vehicles
    selected_vehicles.sort_by do |vehicle|
      vehicle.stops_away(stop)
    end
  end

  private

  def trip_id entity
    entity["vehicle"]["trip"]["trip_id"].to_i
  end

  def relevant_trips
    response.select {|obj| stop.trip_ids.include?(trip_id(obj))}
  end

  def new_vehicle obj
    vehicle = obj["vehicle"]
    trip = vehicle["trip"]
    Vehicle.new(id: vehicle["vehicle"]["id"], trip_id: trip["trip_id"], stop_id: vehicle["stop_id"], route_id: trip["route_id"])
  end

  def new_vehicles
    relevant_trips.map{|obj| new_vehicle(obj) }
  end

  def selected_vehicles
    new_vehicles.select {|vehicle| vehicle.stops_away(stop) > 0}
  end

end
