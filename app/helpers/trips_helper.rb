module TripsHelper
  def display_steps(trip)
    breadcrumbs = ""
    trip.points.each do |step|
      breadcrumbs << step.city
      breadcrumbs << " &rarr; " unless step == trip.points.last
    end
    breadcrumbs.html_safe
 end
end
