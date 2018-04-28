require 'tiny_tds'

class SMS
  def self.send_sms(phone_nbr, content)
    client = TinyTds::Client.new(username: ENV['sms_user'], password: ENV['sms_pwd'], host: ENV['sms_host'], port: ENV['sms_port'].to_i, database: ENV['sms_db'], tds_version: '7.0')
    content.gsub!("'","''")
    sql = "Insert into SMSend_khzc_xj(DestTermID, MsgLen, MsgContent) VALUES ('#{phone_nbr}', 0, '#{content}')"
    result = client.execute(sql)
    result.insert()
    client.close()
  end
end
