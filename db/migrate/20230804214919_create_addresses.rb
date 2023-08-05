class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :city
      t.string :street
      t.string :country

      t.timestamps
    end
  end
end
