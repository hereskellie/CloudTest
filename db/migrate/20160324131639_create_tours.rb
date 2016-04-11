class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :firstname
      t.string :lastname
      t.string :language
      t.decimal :cost
      t.string :description

      t.timestamps null: false
    end
  end
end
