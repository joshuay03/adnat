class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.belongs_to :organisation
      t.string :name, null: false
      t.string :email_address, null: false
      t.string :password, null: false

      t.timestamps
    end
  end
end
