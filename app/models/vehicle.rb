class Vehicle < ApplicationRecord
  belongs_to :trip
  belongs_to :route
  belongs_to :stop
  has_many :stops, :through => :trip
  attr_reader :user_stop

  def stops_away user_stop
    usi = user_stop_index(user_stop)
    csi = current_stop_index
    @stops_away = usi - csi
  end

  private

  def user_stop_index user_stop
    stops.index(user_stop)
  end

  def current_stop_index
    stops.index(stop)
  end

end
