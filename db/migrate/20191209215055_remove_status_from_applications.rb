class RemoveStatusFromApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :applications, :status, :string
  end
end
