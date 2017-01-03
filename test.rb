require './qingyun-api-demo'

q = QingyunApiDemo.new('', '', '')# example zone_id: sh1a, (上海1区-A)
puts q.desc_instance 'your_instance_id'

i = q.c_instance({
                     image_id: 'xenialx64b',
                     cpu: 1,
                     memory: 1024,
                     count: 1,       #default 1
                     instance_name: 'for-test',
                     'vxnets.n': 'vxnet-0',      # 基础网络
                     zone: 'sh1a',
                     login_mode: 'passwd',
                     login_passwd: 'Chenbin123'
                 })[0]

ip = q.c_ip(
    {
        bandwidth: 1,
        billing_mode: 'traffic',    #bandwidth
        eip_name: 'for-test-ip',
        count: 1,                   # default 1
        zone: 'sh1a',
    }
)[0]

# wait instance
q.wait_instance_for_status(i, 'running')

q.wait_ip_for_status(ip, 'available')
p 'Associate IP..'
puts q.ass_ip(i, ip)
sleep 20

q.wait_ip_for_status(ip, 'associated')
p 'Disassociate IP..'
puts q.dis_ass_ip(ip)

sleep 20


p 'ShutDown...'
puts q.shut_instance(i)
q.wait_instance_for_status(i, 'stopped')

sleep 10
p 'Destroy ..'
puts q.des_instance(i)

q.wait_ip_for_status(ip, 'available')
p 'Release IP..'
puts q.release_ip(ip)

q.wait_ip_for_status(ip, 'released')