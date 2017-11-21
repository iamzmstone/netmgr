class CreateVlans < ActiveRecord::Migration[5.1]
  def change
    create_table :vlans do |t|
      t.integer :switch_id
      t.integer :vlan
      t.string :remark
      t.string :gateway
      t.string :netmask

      t.timestamps
    end
    add_index :vlans, :switch_id
  end
end
