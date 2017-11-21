class CreateMibPorts < ActiveRecord::Migration[5.1]
  def change
    create_table :mib_ports do |t|
      t.integer :switch_id
      t.integer :if_nbr
      t.string :port_desc

      t.timestamps
    end
    add_index :mib_ports, :switch_id
  end
end
