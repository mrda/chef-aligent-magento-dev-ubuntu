#
# Cookbook Name:: aligent-magento-dev
# Recipe:: redis
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

if node['app']['cache_backend'] == 'redis' || node['app']['session_backend'] == 'redis'
  include_recipe "redis2"
end

if node['app']['cache_backend'] == 'redis'
  # Remove old style "redis_prime" instance if it exists.
  file ::File.join(node["redis2"]["conf_dir"], "redis_prime.conf") do
    action :delete
    notifies :disable, "runit_service[redis_prime]"
  end

  runit_service "redis_prime" do
    action :disable
  end

  # Create cache instance using attribute values
  redis_instance "cache"

end

if node['app']['session_backend'] == 'redis'
  # Create session instance using attribute values
  redis_instance "session"
end
