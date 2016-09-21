#
## Cookbook Name:: aligent-magento-dev
## Recipe:: ioncube
##
## Copyright 2016, Aligent Consulting
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

if node['app']['ioncube']['enabled']
    include_recipe 'php-ioncube::install'

	file '/etc/php.d/ioncube.ini' do
		action :delete
		only_if { File.exist? '/etc/php.d/ioncube.ini' }
	end

	file "/etc/php.d/05-ioncube.ini" do
		owner 'root'
		group 'root'
		mode 0755
		content 'zend_extension=/usr/local/ioncube/ioncube_loader_lin_5.6.so'
		action :create
	end

end
