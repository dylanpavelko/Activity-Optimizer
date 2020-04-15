class AddProjectToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_reference :participants, :project, foreign_key: true
  end
end
