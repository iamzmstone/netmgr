require 'tiny_tds'

class SMS
  def self.send_sms(phone_nbr, content)
    client = TinyTds::Client.new(username: 'userkhzc', password: '298dkKsdk,8d', host: '202.107.225.201', port: 2010, database: 'sxzjcn', tds_version: '7.0')
    sql = "INSERT INTO SMSend_SZCG(DestTermID, MsgLen, MsgContent) VALUES ('#{phone_nbr}', 0, '#{content}')"
    result = client.execute(sql)
    result.insert()
    client.close()
  end
end