class Vlan < ApplicationRecord
  belongs_to :switch

  def min_ip
    fs = gateway.split('.')
    (fs[0..2] << (fs[-1].to_i + 1).to_s).join('.')
  end

  def self.find_by_ip(ip)
    Vlan.all.each do |v|
      net = IPAddr.new("#{v.gateway}/#{v.netmask}")
      return v if net.include?(ip)
    end
    nil
  end
end
