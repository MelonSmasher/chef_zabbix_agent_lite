name 'zabbix_agent_lite'
maintainer 'Alex Markessinis'
maintainer_email 'markea125@gmail.com'
license 'MIT'
description 'Installs and configures the Zabbix agent with minimal cookbook dependencies.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

issues_url 'https://github.com/melonsmasher/chef_zabbix_agent_lite/issues' if respond_to?(:issues_url)
source_url 'https://github.com/melonsmasher/chef_zabbix_agent_lite' if respond_to?(:source_url)

version '0.1.8'

chef_version ">= 12.11" if respond_to?(:chef_version)

supports 'ubuntu', '>= 14.04'
supports 'debian', '>= 8.0'
supports 'centos', '>= 7.0'
supports 'redhat', '>= 7.0'
supports 'oracle', '>= 7.0'
supports 'windows'

depends 'chocolatey', '~> 2.0.0'
