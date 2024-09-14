class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
