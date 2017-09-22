default['app']['xdebug']['enable'] = true
default['app']['xdebug']['version'] = "stable"
default['app']['xdebug']['remote_ip'] = "192.168.34.1"

default['app']['name'] = "magento"
default['app']['document_root'] = "/vagrant/public"
default['app']['run_codes'] = {}
default['app']['server_params'] = {}
default['app']['local_xml_cookbook'] = 'aligent-magento-dev-ubuntu'

default['app']['cache_backend'] = 'redis';
default['app']['cache_backend_redis']['prefix'] = 'dev_'
default['app']['cache_backend_redis']['server'] = 'localhost'
default['app']['cache_backend_redis']['port'] = '6379'

default['app']['session_backend'] = "files"
default['app']['session_backend_redis']['server'] = 'localhost'
default['app']['session_backend_redis']['port'] = '6380'

default['app']['fpc_backend'] = 'magento'

default['app']['primary_user'] = "vagrant"
default['app']['cron_user'] = "vagrant"
default['app']['cron_mailto'] = "sysadmin@aligent.com.au"

default['app']['vhost_cookbook'] = 'aligent-magento-dev-ubuntu'

default['app']['database_engine'] = 'mysql'

default['app']['opcache']['installed'] = false
default['app']['opcache']['enabled'] = true
default['app']['opcache']['max_accelerated_files'] = 20000
default['app']['opcache']['validate_timestamps'] = 0
default['app']['opcache']['revalidate_freq'] = 60
default['app']['opcache']['memory_consumption'] = 64
default['app']['opcache']['interned_strings_buffer'] = 4
default['app']['opcache']['fast_shutdown'] = 0
default['app']['opcache']['load_comments'] = 1
default['app']['opcache']['save_comments'] = 1

default['app']['php']['memory_limit'] = '1024M'

default['app']['prompt']['stack'] = 'vagrant'
default['app']['prompt']['role'] = 'default'

default['app']['imagick']['enable'] = false
default['app']['imagick']['version'] = "stable"

default['app']['dev']['phpunit']['disable_modules'] = []

default['app']['templates']['before'] = "varnish.service"
default['app']['templates']['after'] = "cloud-final.service"
default['app']['templates']['file_list'] = '/etc/default/varnish-elb /etc/my.conf'
default['app']['templates']['process_template_cookbook'] = 'aligent-magento-dev-ubuntu'

default['varnish']['version'] = '3.0'
default['varnish']['vcl_cookbook'] = 'aligent-magento-dev-ubuntu'
default['varnish']['backend_host'] = 'localhost'
default['varnish']['backend_port'] = 80

default['app']['ioncube']['enabled'] = false

default["redis2"]["instances"]["cache"]["port"] = default['app']['cache_backend_redis']['port']
default["redis2"]["instances"]["cache"]["appendonly"] = "no"
default["redis2"]["instances"]["cache"]["appendfsync"] = "everysec"
default["redis2"]["instances"]["cache"]["bgsave"] = false

default["redis2"]["instances"]["session"]["port"] = default['app']['session_backend_redis']['port']
default["redis2"]["instances"]["session"]["appendonly"] = "yes"
default["redis2"]["instances"]["session"]["appendfsync"] = "everysec"
default["redis2"]["instances"]["session"]["bgsave"] = false

default['cwlogs']['region'] = 'ap-southeast-2'
default['cwlogs']['state_file_dir'] = '/var/awslogs/state'
default['cwlogs']['state_file_name'] = 'agent-state'

default['cwlogs']['logfiles']['system-messages'] = {
  :log_stream_name  => 'system-messages-{ip_address}',
  :log_group_name   => '%AWS_ENV_NAME%-%AWS_ROLE_NAME%',
  :file             => '/var/log/messages',
  :datetime_format  => '%b %d %H:%M:%S',
  :initial_position => 'start_of_file'
}

default['cwlogs']['logfiles']['system-secure'] = {
  :log_stream_name  => 'system-secure-{ip_address}',
  :log_group_name   => '%AWS_ENV_NAME%-%AWS_ROLE_NAME%',
  :file             => '/var/log/secure',
  :datetime_format  => '%b %d %H:%M:%S',
  :initial_position => 'start_of_file'
}

default['cwlogs']['logfiles']['system-cron'] = {
  :log_stream_name  => 'system-cron-{ip_address}',
  :log_group_name   => '%AWS_ENV_NAME%-%AWS_ROLE_NAME%',
  :file             => '/var/log/cron',
  :datetime_format  => '%b %d %H:%M:%S',
  :initial_position => 'start_of_file'
}

default['cwlogs']['logfiles']['system-cloud-init.log'] = {
  :log_stream_name  => 'system-cloud-init.log-{ip_address}',
  :log_group_name   => '%AWS_ENV_NAME%-%AWS_ROLE_NAME%',
  :file             => '/var/log/cloud-init.log',
  :datetime_format  => '%b %d %H:%M:%S',
  :initial_position => 'start_of_file'
}

