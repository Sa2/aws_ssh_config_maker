module ConfigWriter
  class << self
    @@ssh_config_path = '~/.ssh/config'
    DEFAULT_USER_NAME = 'ec2-user'
    def write_config(instances)
      
      File.open(@@ssh_config_path, 'w') do |f|
        instances.each do |instance|
          ssh_config = <<-EOS
Host  #{instance[:instance_name]}
  HostName       #{instance[:private_dns_name]}
  User           #{DEFAULT_USER_NAME}
  IdentityFile   ~/.ssh/#{instance[:keypair_name]}.pem

          EOS
          f.puts(ssh_config)
        end
      end
    end
  end
end