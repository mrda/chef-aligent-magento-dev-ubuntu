default['app']['xdebug']['enable'] = true
default['app']['xdebug']['version'] = "stable"
default['app']['xdebug']['remote_ip'] = "192.168.34.1"

default['app']['magento_root'] = "/vagrant/public"

default['varnish']['version'] = '3.0'
default['varnish']['vcl_cookbook'] = 'aligent-magento-dev'
default['varnish']['backend_host'] = 'localhost'
default['varnish']['backend_port'] = 80