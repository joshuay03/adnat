class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.belongs_to :user, null: false
      t.datetime :start, null: false
      t.datetime :finish, null: false
      t.integer :break_length, null: false, default: 0

      t.timestamps
    end
  end
end
