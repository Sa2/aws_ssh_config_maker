module InstanceFetcher
  class << self
    REGION = 'ap-northeast-1'
    @@ec2 = Aws::EC2::Client.new(region: REGION)

    def fetch_gateway_instance
      
      instances = @@ec2.describe_instances(filters:[{ name: "tag:Env", values: ['gateway'] }])
      gateway_instances = []
      instances.reservations.each do |reservation|
        instance = reservation.instances[0]
        gateway_instance_info = {
          'instance_name': get_instance_name(instance),
          'keypair_name': get_keypair_name(instance),
          'private_dns_name': get_private_dns(instance)
        }

        gateway_instances.push(gateway_instance_info)
      end
      gateway_instances
    end

    def fetch_close_instance
      # ec2 = Aws::EC2::Client.new(region: REGION)
      instances = @@ec2.describe_instances(filters:[{ name: "tag:SSHType", values: ['close'] }])
      closed_instances = []
      instances.reservations.each do |reservation|
        instance = reservation.instances[0]

        closed_instance_info = {
          'instance_name': get_instance_name(instance),
          'keypair_name': get_keypair_name(instance),
          'private_dns_name': get_private_dns(instance)
        }

        closed_instances.push(closed_instance_info)
        
      end
      closed_instances
    end

    private
    
    def get_instance_name(instance)
      name_tag_index = instance.tags.find_index do |tag|
        tag.key == 'Name'
      end
      instance.tags[name_tag_index].value
    end

    def get_keypair_name(instance)
      instance.key_name
    end

    def get_private_dns(instance)
      instance.private_dns_name
    end

  end
end