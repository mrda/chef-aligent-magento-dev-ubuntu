#
# Cookbook Name:: aligent-magento-dev-ubuntu
# Recipe:: nfs-snapshot
#
# Copyright 2016, (c) 2016 Aligent Consulting
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
perl_packages = [
    'perl-CPAN',
    'perl-Date-Manip',
    'perl-DateTime-Format-ISO8601',
    'perl-DateTime-Locale',
    'perl-DateTime-TimeZone',
    'perl-File-Slurp',
    'perl-Test-Exception',
    'perl-XML-Parser',
    'perl-XML-SAX',
]
perl_packages.each do |pkg|
    package pkg do
        action :install
    end
end

cpan_client 'Net::Amazon::EC2' do
    user         'root'
    group        'root' 
    install_type 'cpan_module'
    action       'install'
end

# Alestic maintains the upstream of the ec2-tools used here; with one minor exception below
# https://raw.githubusercontent.com/alestic/ec2-consistent-snapshot/8f65903de4a520c1693476022a37fa43c5783d60/ec2-consistent-snapshot
#
# NOTE: this version of ec2-expire-snapshots has a needed feature of only deleteing snaps with a certain tag. As we
# need to delete based on tag now and this patch is in PR (since DEC 2015) we are doing it semi-live.
# https://raw.githubusercontent.com/gnustavo/ec2-expire-snapshots/33fb41786dbf1d06965f4879ca6aa81ba2ebb3da/ec2-expire-snapshots
%w{ec2-consistent-snapshot ec2-expire-snapshots ebs-volume-snapshot}.each do |script|
    cookbook_file "/usr/local/sbin/#{script}" do
        action :create
        source script
        owner  'root'
        group  'root'
        mode   '0750'
    end
end

cron 'nfs_snapshot_script' do
    action  :create
    hour    '15'
    minute  '15'
    user    'root'
    path    '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
    mailto  'sysadmin@aligent.com.au'
    command '/usr/local/sbin/ebs-volume-snapshot'
end

