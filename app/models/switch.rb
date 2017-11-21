class Switch < ApplicationRecord
  has_many :ports, dependent: :destroy
  has_many :vlans, dependent: :destroy
  has_many :mib_ports, dependent: :destroy
end
