class Message < ApplicationRecord
  attr_accessor :vps

  def text
    stop ? success : "not found: stop ID " + self.posted_text
  end

  def vps
    @vps = VehiclePositionsService.new(stop)
  end

  private

  def stop
    @stop = Stop.find_by_id(self.posted_text)
  end

  def success
    if statuses.empty?
      no_news
    elsif statuses.count == 1
      statuses.first
    else
      statuses[0..1].join(", ")
    end
  end

  def no_news
    vps.response.empty? ? "empty API response" : "no buses stopping at #{self.posted_text}"
  end

  def statuses
    @statuses = vps.sorted_vehicles.map{|vehicle| status_update(vehicle)}
  end

  def status_update vehicle
    distance = vehicle.stops_away(stop)
    "#{vehicle.trip.trip_headsign} is #{distance} #{stop_or_stops(distance)} away"
  end

  def stop_or_stops distance
    distance == 1 ? "stop" : "stops"
  end

end
