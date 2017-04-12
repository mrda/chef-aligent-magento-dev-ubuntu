# Based on the Cloudar code at https://github.com/WeAreCloudar/chef-cloudwatch-logs/blob/master/recipes/installer.rb

template '/root/cwlogs.cfg.template' do
  source 'awslogs.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables ({
    :logfiles => node['cwlogs']['logfiles']
  })
end



cookbook_file '/root/install-cloudwatch-logs-agent.sh' do
  source 'install-cloudwatch-logs-agent.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
