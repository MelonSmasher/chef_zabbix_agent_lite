# https://repo.zabbix.com/zabbix/
# The repo version to install
default['zabbix']['agent']['version']['linux']['repo']['deb'] = '3.4'
default['zabbix']['agent']['version']['linux']['repo']['rhel'] = '3.4'
# The explicit version of the agent to install
default['zabbix']['agent']['version']['linux']['deb'] = "1:3.4.14-1+#{node['lsb']['codename']}"
default['zabbix']['agent']['version']['linux']['rhel'] = '3.4.14'

# https://chocolatey.org/packages/zabbix-agent
# The version of the agent to install via Chocolatey
default['zabbix']['agent']['version']['windows'] = '3.4.6'

# Set the location of the configuration path an the service name
case node['platform_family']
when 'debian', 'rhel'
  default['zabbix']['agent']['conf_path'] = '/etc/zabbix/zabbix_agentd.conf'
  default['zabbix']['agent']['service_name'] = 'zabbix-agent'
when 'windows'
  default['zabbix']['agent']['conf_path'] = 'C:\ProgramData\zabbix\zabbix_agentd.conf'
  default['zabbix']['agent']['service_name'] = 'Zabbix Agent'
end

### Config Options ###
# https://www.zabbix.com/documentation/3.4/manual/appendix/config/zabbix_agentd_win
# https://www.zabbix.com/documentation/3.4/manual/appendix/config/zabbix_agentd

# Array of valid servers
default['zabbix']['agent']['config']['Server'] = ['127.0.0.1']
# Array of valid servers for active checks
default['zabbix']['agent']['config']['ServerActive'] = ['127.0.0.1']
# The hostname
default['zabbix']['agent']['config']['Hostname'] = node['fqdn']

# OS specific config
case node['platform_family']
when 'debian', 'rhel'
  default['zabbix']['agent']['config']['LogFile'] = '/var/log/zabbix/zabbix_agentd.log'
  default['zabbix']['agent']['config']['PidFile'] = '/var/run/zabbix/zabbix_agentd.pid'
  default['zabbix']['agent']['config']['Include'] = '/etc/zabbix/zabbix_agentd.d/*.conf'
when 'windows'
  default['zabbix']['agent']['config']['LogFile'] = 'c:\zabbix_agentd.log'
end
