class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.references :user
      t.json :dimensions

      t.timestamps null: false
    end
  end
end
