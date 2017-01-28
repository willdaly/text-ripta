class Message < ApplicationRecord

  def text
    stop ? success : error
  end

  private

  def stop
    @stop ||= Stop.find_by_id(self.posted_text)
  end

  def error
    self.posted_text + " is not a valid stop id"
  end

  def success
    vehicles = VehiclePositionsService.new(stop.trip_ids).new_vehicles
    selected_vehicles = vehicles.select {|vehicle| vehicle.stops_away(stop)}
    sorted_vehicles = selected_vehicles.sort_by do |vehicle|
      vehicle.stops_away(stop)
    end
    strings = sorted_vehicles.map{|vehicle| vehicle.stops_away_string(stop)}
    if strings.empty?
      "found no updates on buses stopping at #{self.posted_text}"
    elsif strings.count == 1
      strings.first
    else
      strings[0..1].join(", ")
    end
  end

end
