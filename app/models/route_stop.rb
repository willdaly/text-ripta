class RouteStop < ApplicationRecord
  belongs_to :stop
  belongs_to :route
end
