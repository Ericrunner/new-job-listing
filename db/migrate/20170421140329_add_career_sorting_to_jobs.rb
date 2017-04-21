class AddCareerSortingToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs,:job_sorting,:string
  end
end
