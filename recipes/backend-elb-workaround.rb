#
## Cookbook Name:: aligent-magento-dev-ubuntu
## Recipe:: backend-elb-workaround
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

if node['app']['varnish']['backend_elb_workaround']
    package "bind-utils" do
        action :install
    end

    cookbook_file "/etc/varnish/elb.vcl" do
        source "varnish/elb.vcl"
        mode 0644
        owner "varnish"
        group "varnish"
    end

    cookbook_file "/etc/default/varnish-elb.template" do
        source "varnish/varnish-elb.template"
        mode 0644
        owner "root"
        group "root"
    end

    cookbook_file "/usr/local/bin/generate_backends" do
        source "varnish/generate_backends"
        mode 0755
        owner "root"
        group "root"
    end

    cookbook_file "/usr/local/bin/reload_vcl" do
        source "varnish/reload_vcl"
        mode 0755
        owner "root"
        group "root"
    end

    cookbook_file "/usr/lib/systemd/system/varnish-elb.service" do
        source "varnish/varnish-elb.service"
        mode 0644
        owner "root"
        group "root"
    end

    cookbook_file "/usr/lib/systemd/system/varnish-elb.timer" do
        source "varnish/varnish-elb.timer"
        mode 0644
        owner "root"
        group "root"
    end

    cookbook_file "/usr/lib/systemd/system/varnish-reload.service" do
        source "varnish/varnish-reload.service"
        mode 0644
        owner "root"
        group "root"
    end

    cookbook_file "/usr/lib/systemd/system/varnish-reload.path" do
        source "varnish/varnish-reload.path"
        mode 0644
        owner "root"
        group "root"
    end

    bash 'extract_module' do
        code <<-EOH
        systemctl daemon-reload
        systemctl enable varnish-elb.service
        systemctl enable varnish-elb.timer
        systemctl start varnish-elb.timer
        systemctl enable varnish-reload.service
        systemctl enable varnish-reload.path
        EOH
    end

end
