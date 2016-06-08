#
# Cookbook Name:: aligent-magento-dev
# Recipe:: magento2-cron
#
# Copyright 2016, Aligent Consulting
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

if node['app']['runs_cron']

  #This may start before codedeploy drops the file structure onto the server, so manually create a var/log directory to prevent early errors.
  directory "#{node['app']['document_root']}/var/log" do
    owner "apache"
    group "centos"
    mode '0775'
    action :create
    recursive true
  end

  cron 'magento_cron' do
    action :create
    minute '*/1'
    user node['app']['cron_user']
    mailto node['app']['cron_mailto']
    command "/usr/bin/php -c /etc/php/php.ini #{node['app']['document_root']}/bin/magento cron:run >> #{node['app']['document_root']}/var/log/magento.cron.log&"
  end

  cron 'magento_setup_cron' do
    action :create
    minute '*/1'
    user node['app']['cron_user']
    mailto node['app']['cron_mailto']
    command "/usr/bin/php -c /etc/php/php.ini #{node['app']['document_root']}/bin/magento setup:cron:run >> #{node['app']['document_root']}/var/log/setup.cron.log&"
  end

end
