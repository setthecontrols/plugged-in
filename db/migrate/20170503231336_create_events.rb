class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_name, null: false
      t.date :event_date, null: false
      t.time :event_starttime, null: false
      t.time :event_end_time, null: false
      t.string :host_string, null: false
      t.string :event_street_address, null: false
      t.string :event_city, null: false
      t.string :event_state, null: false
      t.integer :event_zip, null: false
      t.boolean :public_event, :default => false
      t.references :host, null: false
      t.references :attendee
      t.references :invitee

      t.timestamps
    end
  end
end
