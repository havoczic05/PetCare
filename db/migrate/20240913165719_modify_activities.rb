class ModifyActivities < ActiveRecord::Migration[6.0]
  def change
    change_table :activities do |t|
      t.change :start_time, :time
      t.change :end_time, :time
      t.rename :start_date, :date
      t.remove :end_date
      t.references :booking, foreign_key: true
    end
  end
end
