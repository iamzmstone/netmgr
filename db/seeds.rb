# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

AdminUser.destroy_all
AdminUser.create!(email: 'admin@telecom.com', password: 'sxdx1718', password_confirmation: 'sxdx1718')
AdminUser.create!(email: 'support@telecom.com', password: 'support@123', password_confirmation: 'support@123')

Switch.destroy_all
# # 7503E
s = Switch.create(name: '市局核心9700', ip: '33.166.127.254', login: 'zengm', password: 'ZengM@123', model: 'HW1-9700')
s.ports.create(port: 'G2/0/16', remark: 'To Yuecheng Link1')
s.ports.create(port: 'G2/0/19', remark: 'To Yuecheng Link2')
s.ports.create(port: 'G2/0/22', remark: 'To Yuecheng Link3')
#s.ports.create(port: 'G4/0/14', remark: 'To Yuecheng Link4')

s.ports.create(port: 'XG1/0/1', remark: 'To Chengdong Link1')
s.ports.create(port: 'XG1/0/2', remark: 'To Chengdong Link2')

# yuecheng
s = Switch.create(name: '越城分局5500', ip: '33.166.127.1', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To 7503E Link1')
s.ports.create(port: 'G1/0/2', remark: 'to tashan')
s.ports.create(port: 'G1/0/3', remark: 'to chengnan')
s.ports.create(port: 'G1/0/4', remark: 'to fushan')
s.ports.create(port: 'G1/0/5', remark: 'to beihai')
#s.ports.create(port: 'G1/0/6', remark: 'To 7503E Link4')
s.ports.create(port: 'G1/0/8', remark: 'To qishan')
s.ports.create(port: 'G1/0/13', remark: 'To Linzhi')
s.ports.create(port: 'G1/0/14', remark: 'To Dongpu')
s.ports.create(port: 'G1/0/15', remark: 'To 7503E Link2')
s.ports.create(port: 'G1/0/16', remark: 'To 7503E Link3')


# fushan
s = Switch.create(name: '府山派出所5500', ip: '33.166.127.2', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To Yuecheng 5500 link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/7', remark: 'To OLT Link3')
s.ports.create(port: 'G1/0/5', remark: 'To H3C 5120 link1')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# chengnan
s = Switch.create(name: '城南派出所5500', ip: '33.166.127.3', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To Yuecheng 5500 link1')
s.ports.create(port: 'G1/0/2', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/4', remark: 'To H3C 5120 Link1')
s.ports.create(port: 'G1/0/5', remark: 'To H3C 5120 link2')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# beihai
s = Switch.create(name: '北海派出所5500', ip: '33.166.127.4', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To Yuecheng 5500 link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/7', remark: 'To OLT Link3')
s.ports.create(port: 'G1/0/5', remark: 'To H3C 5120 link1')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# tashan
s = Switch.create(name: '塔山派出所5500', ip: '33.166.127.5', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To Yuecheng 5500 link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/7', remark: 'To OLT Link3')
s.ports.create(port: 'G1/0/5', remark: 'To H3C 5120 link1')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# qishan
s = Switch.create(name: '蕺山派出所5500', ip: '33.166.127.6', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To Yuecheng 5500 link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/7', remark: 'To OLT Link3')
s.ports.create(port: 'G1/0/5', remark: 'To H3C 5120 link1')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# dongpu
s = Switch.create(name: '东浦派出所5500', ip: '33.166.127.7', model: 'H3C-5500')
s.ports.create(port: 'G1/0/2', remark: 'To Yuecheng 5500 link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/7', remark: 'To OLT Link3')
s.ports.create(port: 'G1/0/5', remark: 'To H3C 5120 link1')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# lingzhi
s = Switch.create(name: '灵芝派出所5500', ip: '33.166.127.8', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To Yuecheng 5500 link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
#s.ports.create(port: 'G1/0/5', remark: 'To H3C 5120 link1')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# paojiang
s = Switch.create(name: '袍江5500', ip: '33.167.127.1', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To 7503E')
s.ports.create(port: 'G1/0/2', remark: 'To doumen')
s.ports.create(port: 'G1/0/3', remark: 'To mashan')
s.ports.create(port: 'G1/0/4', remark: 'To 3500')
s.ports.create(port: 'G1/0/5', remark: 'To sunduan')
s.ports.create(port: 'G1/0/6', remark: 'to-pjprj2016-5120-link1')
s.ports.create(port: 'G1/0/7', remark: 'to-pjprj2016-5120-link2')

s = Switch.create(name: '斗门5500', ip: '33.167.127.2', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To 袍江分局5500 Link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/9', remark: 'To OLT Link3')
s.ports.create(port: 'G1/0/10', remark: 'To OLT Link4')
s.ports.create(port: 'G1/0/6', remark: 'To 5120 Link2')
s.ports.create(port: 'G1/0/8', remark: 'To 5120-new Link2')

s = Switch.create(name: '马山5500', ip: '33.167.127.3', model: 'H3C-5500')
s.ports.create(port: 'G1/0/1', remark: 'To 袍江分局5500 Link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/9', remark: 'To OLT Link3')
s.ports.create(port: 'G1/0/5', remark: 'To 5120 Link1')
s.ports.create(port: 'G1/0/7', remark: 'To 5120-new Link1')
s.ports.create(port: 'G1/0/8', remark: 'To 5120-new Link2')

s = Switch.create(name: '孙端5500', ip: '33.167.127.4', model: 'H3C-5500')
s.ports.create(port: 'G1/0/2', remark: 'To 袍江分局5500 Link1')
s.ports.create(port: 'G1/0/3', remark: 'To OLT Link1')
s.ports.create(port: 'G1/0/4', remark: 'To OLT Link2')
s.ports.create(port: 'G1/0/5', remark: 'To 5120 Link1')
s.ports.create(port: 'G1/0/6', remark: 'To 5120 Link2')
s.ports.create(port: 'Ten1/1/1', remark: 'to-chengdong-hexin')

# jiaojing huawei 12800
s = Switch.create(name: '视频监控网:Huawei12800', ip: '33.175.31.1', login: 'zengmin', password: 'ZengM@123', model: 'HW-12800')
s.ports.create(port: '10GE1/8/0/0', remark: 'eth-trunk 100: To 中心局 OLT Link1')
s.ports.create(port: '10GE2/8/0/0', remark: 'eth-trunk 100: To 中心局 OLT Link2')
s.ports.create(port: '10GE1/8/0/1', remark: 'eth-trunk 101: To 城南局 OLT Link1')
s.ports.create(port: '10GE2/8/0/1', remark: 'eth-trunk 101: To 城南局 OLT Link2')
s.ports.create(port: '10GE1/8/0/2', remark: 'eth-trunk 102: To 城北局 OLT Link1')
s.ports.create(port: '10GE2/8/0/2', remark: 'eth-trunk 102: To 城北局 OLT Link2')
s.ports.create(port: '10GE1/8/0/3', remark: 'eth-trunk 103: To 斗门局 OLT Link1')
s.ports.create(port: '10GE2/8/0/3', remark: 'eth-trunk 103: To 斗门局 OLT Link2')
s.ports.create(port: '10GE1/8/0/4', remark: 'eth-trunk 104: To 城西局 OLT Link1')
s.ports.create(port: '10GE2/8/0/4', remark: 'eth-trunk 104: To 城西局 OLT Link2')
s.ports.create(port: '10GE1/8/0/5', remark: 'eth-trunk 105: To 城东局 OLT Link1')
s.ports.create(port: '10GE2/8/0/5', remark: 'eth-trunk 105: To 城东局 OLT Link2')

s.ports.create(port: '10G1/6/0/4', remark: 'eth-trunk 109: To 马山局 OLT Link1')
s.ports.create(port: '10G2/6/0/4', remark: 'eth-trunk 109: To 马山局 OLT Link2')
s.ports.create(port: '10G1/6/0/5', remark: 'eth-trunk 110: To 齐贤局 OLT Link1')
s.ports.create(port: '10G2/6/0/5', remark: 'eth-trunk 110: To 齐贤局 OLT Link2')
s.ports.create(port: '10G1/6/0/6', remark: 'eth-trunk 111: To 皋埠局 OLT Link1')
s.ports.create(port: '10G2/6/0/6', remark: 'eth-trunk 111: To 皋埠局 OLT Link2')
s.ports.create(port: '10G1/6/0/7', remark: 'eth-trunk 112: To 孙端局 OLT Link1')
s.ports.create(port: '10G2/6/0/7', remark: 'eth-trunk 112: To 孙端局 OLT Link2')

s.ports.create(port: '10GE1/8/0/21', remark: 'eth-trunk 12: qianweifeng-qqy-20160429 Link1')
s.ports.create(port: '10GE2/8/0/21', remark: 'eth-trunk 12: qianweifeng-qqy-20160429 Link2')

# jiaojing huawei 7700
s = Switch.create(name: '数据流量网:Huawei7700', ip: '33.175.63.1', login: 'zengm', password: 'ZengM@123', model: 'HW1-7700')
s.ports.create(port: 'G1/4/0/0', remark: 'eth-trunk 1: To 中心局 OLT Link1')
s.ports.create(port: 'G2/4/0/0', remark: 'eth-trunk 1: To 中心局 OLT Link2')
s.ports.create(port: 'G1/4/0/1', remark: 'eth-trunk 2: To 城南局 OLT Link1')
s.ports.create(port: 'G2/4/0/1', remark: 'eth-trunk 2: To 城南局 OLT Link2')
s.ports.create(port: 'G1/4/0/2', remark: 'eth-trunk 3: To 城北局 OLT Link1')
s.ports.create(port: 'G2/4/0/2', remark: 'eth-trunk 3: To 城北局 OLT Link2')
s.ports.create(port: 'G1/4/0/3', remark: 'eth-trunk 4: To 斗门局 OLT Link1')
s.ports.create(port: 'G2/4/0/3', remark: 'eth-trunk 4: To 斗门局 OLT Link2')
s.ports.create(port: 'G1/4/0/4', remark: 'eth-trunk 5: To 城西局 OLT Link1')
s.ports.create(port: 'G2/4/0/4', remark: 'eth-trunk 5: To 城西局 OLT Link2')
s.ports.create(port: 'G1/4/0/5', remark: 'eth-trunk 6: To 城东局 OLT Link1')
s.ports.create(port: 'G2/4/0/5', remark: 'eth-trunk 6: To 城东局 OLT Link2')

s.ports.create(port: 'G1/4/0/6', remark: 'eth-trunk 7: To 齐贤局 OLT Link1')
s.ports.create(port: 'G2/4/0/6', remark: 'eth-trunk 7: To 齐贤局 OLT Link2')
s.ports.create(port: 'G1/4/0/7', remark: 'eth-trunk 8: To 马山局 OLT Link1')
s.ports.create(port: 'G2/4/0/7', remark: 'eth-trunk 8: To 马山局 OLT Link2')
s.ports.create(port: 'XG1/2/0/3', remark: 'eth-trunk 9: To 皋埠局 OLT Link1')
s.ports.create(port: 'XG2/2/0/3', remark: 'eth-trunk 9: To 皋埠局 OLT Link2')
s.ports.create(port: 'XG1/2/0/4', remark: 'eth-trunk 10: To 孙端局 OLT Link1')
s.ports.create(port: 'XG2/2/0/4', remark: 'eth-trunk 10: To 孙端局 OLT Link2')

# chengdong huawei 12800
s = Switch.create(name: '城东公安核心:Huawei12800', ip: '33.168.127.1', login: 'zengmin', password: 'Huawei@123', model: 'HW-12800')
s.ports.create(port: '10GE1/8/0/0', remark: 'To 府山派出所5500 Link1')
s.ports.create(port: '10GE1/8/0/1', remark: 'To 城南派出所5500 Link1')
s.ports.create(port: '10GE1/8/0/2', remark: 'To 北海派出所5500 Link1')
s.ports.create(port: '10GE1/8/0/3', remark: 'To 塔山派出所5500 Link1')
s.ports.create(port: '10GE1/8/0/4', remark: 'To 蕺山派出所5500 Link1')
s.ports.create(port: '10GE1/8/0/5', remark: 'To 东浦派出所5500 Link1')
s.ports.create(port: '10GE1/8/0/6', remark: 'To 灵芝派出所5500 Link1')
s.ports.create(port: '10GE1/8/0/8', remark: 'To 皋埠派出所5120 Link1')
s.ports.create(port: '10GE1/8/0/9', remark: 'To 高新分局5500 Link1')
s.ports.create(port: '10GE1/8/0/13', remark: 'To 东湖派出所5120 Link1')
s.ports.create(port: '10GE1/8/0/14', remark: 'To 稽山派出所5120 Link1')


s.ports.create(port: '10GE1/8/0/7', remark: 'eth-trunk 4: To 市局7503E Link1')
s.ports.create(port: '10GE2/8/0/7', remark: 'eth-trunk 4: To 市局7503E Link2')

s.ports.create(port: '10GE1/8/0/12', remark: 'eth-trunk 1: To 城东OLT Link1')
s.ports.create(port: '10GE2/8/0/12', remark: 'eth-trunk 1: To 城东OLT Link2')

s.ports.create(port: '10GE1/8/0/11', remark: 'eth-trunk 2: To 城南OLT Link1')
s.ports.create(port: '10GE2/8/0/11', remark: 'eth-trunk 2: To 城南OLT Link2')

s.ports.create(port: '10GE1/8/0/24', remark: 'eth-trunk 23: To 皋埠OLT Link1')
s.ports.create(port: '10GE2/8/0/24', remark: 'eth-trunk 23: To 皋埠OLT Link2')

s.ports.create(port: '10GE1/8/0/25', remark: 'eth-trunk 24: To 富盛OLT Link1')
s.ports.create(port: '10GE2/8/0/25', remark: 'eth-trunk 24: To 富盛OLT Link2')

s.ports.create(port: '10GE1/8/0/26', remark: 'eth-trunk 25: To 陶堰OLT Link1')
s.ports.create(port: '10GE2/8/0/26', remark: 'eth-trunk 25: To 陶堰OLT Link2')

s.ports.create(port: '10GE1/8/0/27', remark: 'eth-trunk 26: To 城北OLT Link1')
s.ports.create(port: '10GE2/8/0/27', remark: 'eth-trunk 26: To 城北OLT Link2')

s.ports.create(port: '10GE1/8/0/34', remark: 'eth-trunk 34: To 城西OLT Link1')
s.ports.create(port: '10GE2/8/0/34', remark: 'eth-trunk 34: To 城西OLT Link2')

s.ports.create(port: '10GE1/8/0/35', remark: 'eth-trunk 35: To 中心OLT Link1')
s.ports.create(port: '10GE2/8/0/35', remark: 'eth-trunk 35: To 中心OLT Link2')

s.ports.create(port: '10GE1/8/0/36', remark: 'eth-trunk 36: To 斗门OLT Link1')
# s.ports.create(port: '10GE2/8/0/36', remark: 'eth-trunk 36: To 斗门OLT Link2')

s.ports.create(port: '10GE1/8/0/37', remark: 'eth-trunk 37: To 马山OLT Link1')
# s.ports.create(port: '10GE2/8/0/37', remark: 'eth-trunk 37: To 马山OLT Link2')

# s.ports.create(port: '10GE1/8/0/39', remark: 'eth-trunk 39: To 齐贤OLT Link1')
s.ports.create(port: '10GE2/8/0/39', remark: 'eth-trunk 39: To 齐贤OLT Link2')

s.ports.create(port: '10GE1/8/0/10', remark: 'eth-trunk 41: To 孙端OLT Link1')
s.ports.create(port: '10GE2/8/0/10', remark: 'eth-trunk 41: To 孙端OLT Link2')
s.ports.create(port: '10GE1/8/0/15', remark: 'To 孙端派出所h3c5500')

s.ports.create(port: '10GE1/8/0/16', remark: 'eth-trunk 5: To h3c5500-3# Link1')
s.ports.create(port: '10GE2/8/0/16', remark: 'eth-trunk 5: To h3c5500-3# Link2')
s.ports.create(port: '10GE1/8/0/17', remark: 'eth-trunk 14: To h3c5500-4# Link1')
s.ports.create(port: '10GE1/8/0/18', remark: 'eth-trunk 3: To h3c5500-2# Link1')
s.ports.create(port: '10GE2/8/0/18', remark: 'eth-trunk 3: To h3c5500-2# Link2')

s.ports.create(port: '10GE1/8/0/20', remark: 'eth-trunk 6: To h3c5120-1# Link1')
s.ports.create(port: '10GE2/8/0/20', remark: 'eth-trunk 6: To h3c5120-1# Link2')
s.ports.create(port: '10GE1/8/0/21', remark: 'eth-trunk 7: To h3c5120-2# Link1')
s.ports.create(port: '10GE2/8/0/21', remark: 'eth-trunk 7: To h3c5120-2# Link2')
s.ports.create(port: '10GE1/8/0/22', remark: 'eth-trunk 8: To h3c5120-3# Link1')
s.ports.create(port: '10GE2/8/0/22', remark: 'eth-trunk 8: To h3c5120-3# Link2')
s.ports.create(port: '10GE1/8/0/23', remark: 'eth-trunk 9: To h3c5120-4# Link1')
s.ports.create(port: '10GE2/8/0/23', remark: 'eth-trunk 9: To h3c5120-4# Link2')
s.ports.create(port: '10GE1/8/0/28', remark: 'eth-trunk 27: To h3c5120-5# Link1')
s.ports.create(port: '10GE2/8/0/28', remark: 'eth-trunk 27: To h3c5120-5# Link2')
s.ports.create(port: '10GE1/8/0/29', remark: 'eth-trunk 28: To h3c5120-6# Link1')
s.ports.create(port: '10GE2/8/0/29', remark: 'eth-trunk 28: To h3c5120-6# Link2')
s.ports.create(port: '10GE1/8/0/30', remark: 'eth-trunk 29: To h3c5120-7# Link1')
s.ports.create(port: '10GE2/8/0/30', remark: 'eth-trunk 29: To h3c5120-7# Link2')
s.ports.create(port: '10GE1/8/0/31', remark: 'eth-trunk 30: To h3c5120-8# Link1')
s.ports.create(port: '10GE2/8/0/31', remark: 'eth-trunk 30: To h3c5120-8# Link2')
s.ports.create(port: '10GE2/8/0/0', remark: 'eth-trunk 31: To h3c5500-5# Link1')
s.ports.create(port: '10GE2/8/0/1', remark: 'eth-trunk 31: To h3c5500-5# Link2')
s.ports.create(port: '10GE2/8/0/2', remark: 'eth-trunk 32: To h3c5500-6# Link1')
s.ports.create(port: '10GE2/8/0/3', remark: 'eth-trunk 32: To h3c5500-6# Link2')
s.ports.create(port: '10GE2/8/0/4', remark: 'eth-trunk 33: To h3c5500-7# Link1')
s.ports.create(port: '10GE2/8/0/5', remark: 'eth-trunk 33: To h3c5500-7# Link2')
s.ports.create(port: '10GE1/8/0/19', remark: 'eth-trunk 38: To h3c5500-1# Link1')
s.ports.create(port: '10GE2/8/0/19', remark: 'eth-trunk 38: To h3c5500-1# Link2')
s.ports.create(port: '10GE2/8/0/15', remark: 'eth-trunk 38: To h3c5500-1# Link3')
s.ports.create(port: '10GE2/8/0/6', remark: 'eth-trunk 40: To h3c5120-9# Link1')
s.ports.create(port: '10GE2/8/0/9', remark: 'eth-trunk 40: To h3c5120-9# Link2')
s.ports.create(port: '10GE1/8/0/32', remark: 'eth-trunk 42: To h3c5120-10# Link1')
s.ports.create(port: '10GE2/8/0/32', remark: 'eth-trunk 42: To h3c5120-10# Link2')
s.ports.create(port: '10GE1/8/0/33', remark: 'eth-trunk 43: To h3c5120-11# Link1')
s.ports.create(port: '10GE2/8/0/33', remark: 'eth-trunk 43: To h3c5120-11# Link2')
# s.ports.create(port: '10GE1/8/0/40', remark: 'eth-trunk 44: To paojiang fenju 6th floor Link1')
s.ports.create(port: '10GE2/8/0/40', remark: 'eth-trunk 44: To paojiang fenju 6th floor Link2')
s.ports.create(port: '10GE1/8/0/41', remark: 'eth-trunk 45: To police shiping yun')
s.ports.create(port: '10GE1/8/0/42', remark: 'eth-trunk 46: To zhjt hw12800 link1')
s.ports.create(port: '10GE2/8/0/42', remark: 'eth-trunk 46: To zhjt hw12800 link2')


# jishan gaobu donghu
s = Switch.create(name: '稽山派出所5120', ip: '33.168.127.2', model: 'H3C-5120')
s = Switch.create(name: '皋埠派出所5120', ip: '33.168.127.3', model: 'H3C-5120')
s = Switch.create(name: '东湖派出所5120', ip: '33.168.127.4', model: 'H3C-5120')

# keqiao hw 9312
s = Switch.create(name: '柯桥核心:HW9312', ip: '33.173.207.1', login: 'huawei', password: 'Huawei@123', model: 'HW1-9312')
s.ports.create(port: 'g1/3/0/0', remark: 'eth-trunk 1: 钱清OLT link1')
s.ports.create(port: 'g2/3/0/0', remark: 'eth-trunk 1: 钱清OLT link2')
s.ports.create(port: 'g1/3/0/1', remark: 'eth-trunk 2: 福全OLT link1')
s.ports.create(port: 'g2/3/0/1', remark: 'eth-trunk 2: 福全OLT link2')
s.ports.create(port: 'g1/3/0/2', remark: 'eth-trunk 3: 平水OLT link1')
s.ports.create(port: 'g2/3/0/2', remark: 'eth-trunk 3: 平水OLT link2')
s.ports.create(port: 'g1/3/0/3', remark: 'eth-trunk 4: 稽东OLT link1')
s.ports.create(port: 'g2/3/0/3', remark: 'eth-trunk 4: 稽东OLT link2')
s.ports.create(port: 'g1/3/0/4', remark: 'eth-trunk 5: 王坛OLT link1')
s.ports.create(port: 'g2/3/0/4', remark: 'eth-trunk 5: 王坛OLT link2')
s.ports.create(port: 'g1/3/0/5', remark: 'eth-trunk 6: 齐贤OLT link1')
s.ports.create(port: 'g2/3/0/15', remark: 'eth-trunk 6: 齐贤OLT link2')
s.ports.create(port: 'g1/3/0/6', remark: 'eth-trunk 7: 滨海OLT link1')
s.ports.create(port: 'g2/3/0/6', remark: 'eth-trunk 7: 滨海OLT link2')
s.ports.create(port: 'g1/3/0/7', remark: 'eth-trunk 8: 柯桥局OLT link1')
s.ports.create(port: 'g2/3/0/7', remark: 'eth-trunk 8: 柯桥局OLT link2')
s.ports.create(port: 'g1/3/0/8', remark: 'eth-trunk 9: 湖塘局OLT link1')
s.ports.create(port: 'g2/3/0/8', remark: 'eth-trunk 9: 湖塘局OLT link2')
s.ports.create(port: 'g1/3/0/9', remark: 'eth-trunk 10: 安昌局OLT link1')
s.ports.create(port: 'g2/3/0/9', remark: 'eth-trunk 10: 安昌局OLT link2')
s.ports.create(port: 'xg1/1/0/0', remark: 'eth-trunk 13: 柯桥局公安 link1')
s.ports.create(port: 'xg2/1/0/0', remark: 'eth-trunk 13: 柯桥局公安 link2')
s.ports.create(port: 'xg1/2/0/0', remark: 'eth-trunk 14: 娄宫OLT link1')
s.ports.create(port: 'xg2/2/0/0', remark: 'eth-trunk 14: 娄宫OLT link2')

# jiaojing 10th floor h3c 7606
s = Switch.create(name: '交警支队10楼:H3C7606', ip: '33.166.127.201', model: 'H3C-7606')
s.ports.create(port: 'g3/0/1', remark: 'to 市公安9700')
s.ports.create(port: 'g3/0/2', remark: 'to OLT C300')
s.ports.create(port: 'g3/0/3', remark: 'to h3c 5120')
s.ports.create(port: 'g3/0/4', remark: 'to 交警支队10楼智慧交通HWS9706 link1')
s.ports.create(port: 'g3/0/5', remark: 'to 电信18楼H3C5500')
s.ports.create(port: 'g3/0/6', remark: 'to 交警支队10楼智慧交通HWS9706 link2')

# dongjie 18th floor h3c 5500
s = Switch.create(name: '东街18楼:H3C5500', ip: '33.166.127.202', model: 'H3C-5500')
s.ports.create(port: 'g1/0/25', remark: 'to jiaojing7606')
s.ports.create(port: 'g1/0/26', remark: 'to 18th floor BRT OLT')
s.ports.create(port: 'g1/0/27', remark: 'to doumen BRT OLT')

# jiaojing 10th floor smart traffic huawei 9706
s = Switch.create(name: '交警支队10楼:HW9706', ip: '33.175.28.1', login: 'zengm', password: 'ZengM@123', model: 'HW1-9716')
s.ports.create(port: 'g1/2/0/0', remark: 'eth-trunk 0: to H3C 7606 link1')
s.ports.create(port: 'g2/2/0/0', remark: 'eth-trunk 0: to H3C 7606 link2')
s.ports.create(port: 'x1/1/0/0', remark: 'eth-trunk 100: to.C_S02_A link1')
s.ports.create(port: 'x2/1/0/0', remark: 'eth-trunk 100: to.C_S02_A link2')
s.ports.create(port: 'x1/1/0/1', remark: 'eth-trunk 101: to.C_S02_B link1')
s.ports.create(port: 'x2/1/0/1', remark: 'eth-trunk 101: to.C_S02_B link2')

# police video cloud core switch huawei 12800
s = Switch.create(name: '天翼大厦5楼视频云核心:HW12800', ip: '33.168.200.254', login: 'zengmin', password: 'ZengM@321', model: 'HW-12800')
s.ports.create(port: '10GE1/8/0/0', remark: 'eth-trunk 45: to 城东公安核心huawei 12800')
s.ports.create(port: '10GE1/8/0/4', remark: 'eth-trunk 1: to huawei 9306 link1')
s.ports.create(port: '10GE1/8/0/5', remark: 'eth-trunk 1: to huawei 9306 link2')
s.ports.create(port: '10GE2/8/0/4', remark: 'eth-trunk 1: to huawei 9306 link3')
s.ports.create(port: '10GE2/8/0/5', remark: 'eth-trunk 1: to huawei 9306 link4')
s.ports.create(port: '10GE1/8/0/6', remark: 'eth-trunk 2: to huawei e9-6810 link1')
s.ports.create(port: '10GE1/8/0/7', remark: 'eth-trunk 2: to huawei e9-6810 link2')
s.ports.create(port: '10GE2/8/0/6', remark: 'eth-trunk 2: to huawei e9-6810 link3')
s.ports.create(port: '10GE2/8/0/7', remark: 'eth-trunk 2: to huawei e9-6810 link4')
