require 'larrow/qingcloud'

class QingyunApiDemo
  def self.VERSION
    '0.0.1'
  end
  def initialize(access_key, secret_key, zone_id)
    Larrow::Qingcloud.establish_connection access_key, secret_key, zone_id
    @connection = Larrow::Qingcloud.connection
  end

  # describe instance
  def desc_instance(instance_id)
    @connection.get('DescribeInstances', {'instances.1': instance_id})['instance_set']
  end

  # create instance
  def c_instance(param)
    @connection.get('RunInstances', param)['instances']
  end

  # create public ip
  def c_ip(param)
    @connection.get('AllocateEips', param)['eips']
  end

  def desc_ip(id)
    @connection.get('DescribeEips', {
        'eips.1': id
    })['eip_set']
  end

  # associate ip to instance
  def ass_ip(instance_id, ip)
    @connection.get 'AssociateEip', {
      eip: ip,
      instance: instance_id,
      zone: 'sh1a'
    }
  end

  # disassociate ip
  def dis_ass_ip(ip)
    @connection.get 'DissociateEips', {
      'eips.1': ip,
      zone: 'sh1a',
    }
  end

  # release ip
  def release_ip(ip)
    @connection.get 'ReleaseEips', {
      'eips.1': ip,
      zone: 'sh1a',
    }
  end

  # destroy intance
  def des_instance(instance_id)
    @connection.get 'TerminateInstances', {
      'instances.1': instance_id,
      zone: 'sh1a',
    }
  end

  # shutdown
  def shut_instance(instance_id)
    @connection.get 'StopInstances', {
      'instances.1': instance_id,
      force: 0,
      zone: 'sh1a',
  }
  end

  def wait_ip_for_status(id, status, time_span=1)
    while status != desc_ip(id)[0]['status']
      p "waiting IP for #{status}. current status: #{desc_ip(id)[0]['status']}"
      sleep time_span
    end
  end

  def wait_instance_for_status(id, status, time_span=1)
    while status != desc_instance(id)[0]['status']
      p "waiting instance for #{status}. current status: #{desc_instance(id)[0]['status']}"
      sleep time_span
    end
  end
end
