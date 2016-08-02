#
## Cookbook Name:: aligent-magento-dev
## Recipe:: apache2-cgi-vhost
##
## Copyright 2015, Aligent Consulting
##
## Permission is hereby granted, free of charge, to any person obtaining
## a copy of this software and associated documentation files (the
## "Software"), to deal in the Software without restriction, including
## without limitation the rights to use, copy, modify, merge, publish,
## distribute, sublicense, and/or sell copies of the Software, and to
## permit persons to whom the Software is furnished to do so, subject to
## the following conditions:
##
## The above copyright notice and this permission notice shall be
## included in all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
## EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
## MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
## NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
## LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
## OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
## WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##
#

if platform_family?("rhel") && node['platform_version'].to_f >= 7.0
    apache_module 'proxy' do
        enable true
    end

#    apache_module 'proxy_http' do
#        enable true
#    end

    apache_module 'proxy_fcgi' do
        enable true
    end

    apache_conf 'php-fpm' do
      enable true
    end
else
    package 'mod_fastcgi' do
      action :install
    end

    apache_module 'fastcgi' do
        enable true
        conf true
    end
end


template "#{node[:apache][:dir]}/sites-available/#{node['app']['name']}.conf" do
  source "apache2-cgi-vhost.erb"
  owner "root"
  group "root"
  mode 0644
  cookbook node['app']['vhost_cookbook']
end

apache_site node['app']['name'] do
  enable true
end

include_recipe 'aligent-magento-dev::apache2-common'