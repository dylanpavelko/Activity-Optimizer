class AddProjectToTimeSlot < ActiveRecord::Migration[6.0]
  def change
    add_reference :time_slots, :project, foreign_key: true
  end
end
