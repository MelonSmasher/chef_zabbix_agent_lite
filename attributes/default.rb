# Array of valid servers
default['zabbix']['agent']['config']['Server'] = ['127.0.0.1']
# Array of valid servers for active checks
default['zabbix']['agent']['config']['ServerActive'] = ['127.0.0.1']
# The hostname
default['zabbix']['agent']['config']['Hostname'] = node['fqdn']

default['zabbix']['agent']['version']['linux']['repo']['deb'] = '3.4'
default['zabbix']['agent']['version']['linux']['repo']['rhel'] = '3.4'


case node['platform_family']
when 'windows'
  # https://chocolatey.org/packages/zabbix-agent
  # The version of the agent to install via Chocolatey
  default['zabbix']['agent']['version']['windows'] = '3.4.6'
  default['zabbix']['agent']['conf_path'] = 'C:\ProgramData\zabbix\zabbix_agentd.conf'
  default['zabbix']['agent']['service_name'] = 'Zabbix Agent'

  default['zabbix']['agent']['config']['LogFile'] = 'c:\zabbix_agentd.log'
when 'debian', 'rhel'
  # https://repo.zabbix.com/zabbix/
  # The repo version to install
  # The explicit version of the agent to install
  default['zabbix']['agent']['version']['linux']['deb'] = "1:3.4.15-1+"
  default['zabbix']['agent']['version']['linux']['rhel'] = '3.4.14-1.el7'
  default['zabbix']['agent']['conf_path'] = '/etc/zabbix/zabbix_agentd.conf'
  default['zabbix']['agent']['service_name'] = 'zabbix-agent'

  default['zabbix']['agent']['action']['linux']['deb'] = 'install'
  default['zabbix']['agent']['action']['linux']['rhel'] = 'install'

  default['zabbix']['agent']['config']['LogFile'] = '/var/log/zabbix/zabbix_agentd.log'
  default['zabbix']['agent']['config']['PidFile'] = '/var/run/zabbix/zabbix_agentd.pid'
  default['zabbix']['agent']['config']['Include'] = '/etc/zabbix/zabbix_agentd.d/*.conf'
end
