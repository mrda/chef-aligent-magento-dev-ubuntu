#
# Cookbook Name:: aligent-magento-dev-ubuntu
# Recipe:: magento-localxml
#
# Copyright 2015, (c) 2015 Aligent Consulting
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


directory "#{node['app']['document_root']}/app/etc/" do
  owner "apache"
  group "apache"
  mode 0755
  recursive true
  action :create
end

template "#{node['app']['document_root']}/app/etc/local.xml" do
  source "local.xml.erb"
  cookbook node['app']['local_xml_cookbook']
  mode 0644
  owner node['app']['primary_user']
  group node['app']['primary_user']
end


if node['app']['mysql']['test']['enabled']
  template "#{node['app']['document_root']}/app/etc/local.xml.phpunit" do
    source "local.xml.phpunit.erb"
    mode 0644
    owner node['app']['primary_user']
    group node['app']['primary_user']
  end
end
