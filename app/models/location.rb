class Location < ApplicationRecord
	belongs_to :project, :class_name => "Project"
end
