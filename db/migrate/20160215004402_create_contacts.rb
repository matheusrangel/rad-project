class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :nome
      t.string :email
      t.string :phone
      t.string :address
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
