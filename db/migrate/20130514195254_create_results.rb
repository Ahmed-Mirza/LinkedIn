class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :id
      t.string :firstName
      t.string :lastName

      t.timestamps
    end
  end
end
