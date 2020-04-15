class AddProjectToLocation < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :project, foreign_key: true
  end
end
