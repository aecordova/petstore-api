class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|

      t.timestamps
    end
  end
end
