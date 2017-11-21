class Port < ApplicationRecord
  belongs_to :switch

  def in_usgs
    in_usg.present? ? in_usg.split(',') : []
  end

  def in_usgs=(in_usgs)
    self.in_usg = in_usgs.join(',')
  end

  def out_usgs
    out_usg.present? ? out_usg.split(',') : []
  end

  def out_usgs=(out_usgs)
    self.out_usg = out_usgs.join(',')
  end

  def mib_info
    md = /(\d*\D+)(\d\/.*)/.match(self.port)
    return nil unless md
    return MibPort.where(switch_id: self.switch_id).where("port_desc like '#{md[1].upcase}%#{md[2]}'").first
  end
end
