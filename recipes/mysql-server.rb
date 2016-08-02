#
## Cookbook Name:: aligent-magento-dev
## Recipe:: mysql-server
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

if node['app']['database_engine'] == 'mysql' || node['app']['database_engine'] == nil
    mysql_service 'default' do
        version node['mysql']['server_version']
        bind_address '0.0.0.0'
        port '3306'
        data_dir '/var/lib/mysql'
        initial_root_password node['mysql']['server_root_password']
        action [:create, :start]
    end

    mysql_config 'default' do
        source 'mysql_config.erb'
        notifies :restart, 'mysql_service[default]'
        action :create
    end
else
    include_recipe 'mariadb::server'
end