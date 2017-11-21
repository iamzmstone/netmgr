class CreateSwitches < ActiveRecord::Migration[5.1]
  def change
    create_table :switches do |t|
      t.string :name
      t.string :ip
      t.string :login
      t.string :password
      t.string :model

      t.timestamps
    end
    add_index :switches, :name
  end
end
