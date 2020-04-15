class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.belongs_to :time_slot, foreign_key: true
      t.belongs_to :location, foreign_key: true
      t.belongs_to :project, foreign_key: true

      t.timestamps
    end
  end
end
