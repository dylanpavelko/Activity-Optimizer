class Activity < ApplicationRecord
  belongs_to :time_slot, :class_name => "TimeSlot", :optional => true
  belongs_to :location, :class_name => "Location", :optional => true
  belongs_to :project, :class_name => "Project"

  def display_name
  	if location != nil
  		location_text = self.location.name
  	else
  		location_text = "<No Location Set>"
  	end

  	if time_slot != nil
  		time_text = self.time_slot.name
  	else
  		time_text = "<No Time Slot Set>"
  	end

  	return name + " (" + location_text +"-" + time_text + ")"
  end
end
