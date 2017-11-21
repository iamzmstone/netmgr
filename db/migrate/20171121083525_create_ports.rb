class CreatePorts < ActiveRecord::Migration[5.1]
  def change
    create_table :ports do |t|
      t.integer :switch_id
      t.string :port
      t.integer :speed
      t.string :remark
      t.string :in_usg
      t.string :out_usg
      t.integer :in_err
      t.integer :out_err
      t.string :status

      t.timestamps
    end
    add_index :ports, :switch_id
  end
end
