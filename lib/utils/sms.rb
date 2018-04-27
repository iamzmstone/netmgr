require 'tiny_tds'

class SMS
  def self.send_sms(phone_nbr, content)
    client = TinyTds::Client.new(username: ENV['sms_user'], password: ENV['sms_pwd'], host: '202.107.225.201', port: 2010, database: 'sxzjcn', tds_version: '7.0')
    sql = "Insert into SMSend_khzc_xj(DestTermID, MsgLen, MsgContent) VALUES ('#{phone_nbr}', 0, '#{content}')"
    result = client.execute(sql)
    result.insert()
    client.close()
  end
end
