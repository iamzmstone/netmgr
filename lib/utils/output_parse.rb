require 'pry'

class OutputParse
  def initialize(type = 'H3C')
    @type = type
  end

  def parse(output)
    return ['DOWN', -1, -1, -1, -1, -1] if output =~ /current state\s*: down/mi

    #binding.pry
    rgx_match(@type, output)
  end

  private

  def rgx(type)
    case type
    when 'H3C'
      /(\d+.)bps-speed mode.*bytes\/sec\s+(\d+)%.*bytes\/sec\s+(\d+)%.*(\d+)\s+input errors,.*(\d+)\s+output errors,/mi
    when 'HW'
      /Speed\s*:\s+(\d+),.*Total Error:\s+(\d+).*Buffers Purged:\s+(\d+).*Last 300 seconds input utility rate:\s+([\.\d]+)%.*Last 300 seconds output utility rate:\s+([\.\d]+)%/mi
    when 'HW1'
      /Speed\s*:\s+(\d+),.*Total Error:\s+(\d+).*Total Error:\s+(\d+).*Input bandwidth utilization\s*:\s+([\.\d]+)%.*Output bandwidth utilization\s*:\s+([\.\d]+)%/mi
    else
      /nothing there/
    end
  end

  def rgx_match(type, content)
    rgx = rgx(type)
    md = rgx.match(content)
    unless md
      puts "Failed content:\n#{content}"
      return ['match-failed']
    end

    speed_md = /(\d+)(M|G)/.match(md[1])
    if speed_md
      speed = speed_md[1].to_i if speed_md[2] == 'M'
      speed = speed_md[1].to_i * 1000 if speed_md[2] == 'G'
    else
      speed = md[1].to_i
    end

    case type
    when 'H3C'
      ['UP', md[2].to_f, md[3].to_f, md[4].to_f, md[5].to_f, speed]
    when /HW/
      ['UP', md[4].to_f, md[5].to_f, md[2].to_f, md[3].to_f, speed]
    else
      ['WRONG-TYPE']
    end
  end
end
