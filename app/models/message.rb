class Message < ApplicationRecord

  def text
    stop ? success : "couldn't find a stop by the ID " + self.posted_text
  end

  private

  def stop
    @stop = Stop.find_by_id(self.posted_text)
  end

  def success
    statuses = status_updates
    if statuses.empty?
      "found no updates on buses stopping at #{self.posted_text}"
    elsif statuses.count == 1
      statuses.first
    else
      statuses[0..1].join(", ")
    end
  end

  def status_updates
    vps.response.empty? ? ["empty API response"] : stops_away_strings
  end

  def vps
    @vps = VehiclePositionsService.new(stop)
  end

  def stops_away_strings
    vps.sorted_vehicles.map{|vehicle| vehicle.stops_away_string(stop)}
  end

end
