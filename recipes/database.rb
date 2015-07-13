#
## Cookbook Name:: aligent-magento-dev
## Recipe:: database
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

mysql2_chef_gem 'default' do
  action :install
end

include_recipe "database::mysql"

mysql_connection_info = {
	:host => 'localhost',
	:username => 'root',
	:password => node['mysql']['server_root_password']
}

node['app']['mysql'].each do |db|
    mysql_database db['database']  do
        connection mysql_connection_info
        action :create
    end

    mysql_database_user db['username'] do
        connection mysql_connection_info
        password db['password']
        database_name db['database']
        host db['acl']
        privileges [:all]
        action :grant
    end

end