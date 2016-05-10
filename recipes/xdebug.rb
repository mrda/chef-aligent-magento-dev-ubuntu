#
## Cookbook Name:: aligent-magento-dev
## Recipe:: xdebug
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

if node['app']['xdebug']['enable']

  if node['app']['xdebug']['package'] != nil
    package node['app']['xdebug']['package'] do
      action :install
    end
  else
    # install the xdebug pecl
    php_pear "xdebug" do
      # Specify that xdebug.so must be loaded as a zend extension
      zend_extensions ['xdebug.so']
      version node['app']['xdebug']['version']
      action :install
    end
  end
  template "/etc/php.d/xdebug.ini" do
    source "xdebug.ini.erb"
    mode 0644
    owner "root"
    group "root"
    if node.recipe?('php-fpm')
      notifies :restart, 'service[php-fpm]'
    elsif node.recipe?('apache2::mod_php5')
      notifies :restart, 'service[apache2]'
    end
  end
end