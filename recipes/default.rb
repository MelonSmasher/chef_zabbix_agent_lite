#
# Cookbook:: zabbix_agent_lite
# Recipe:: default
#
# MIT

if %w(windows debian rhel).include?(node['platform_family'])

  case node['platform_family']

  when 'windows'
    zabbix_version_windows = node['zabbix']['agent']['version']['windows']

    # Make sure we have Chocolatey installed.
    include_recipe 'chocolatey::default'
    # Install the agent
    chocolatey_package 'zabbix-agent' do
      version zabbix_version_windows
      action :install
    end

  when 'debian'
    zabbix_version_linux_repo_deb = node['zabbix']['agent']['version']['linux']['repo']['deb']
    zabbix_version_linux_deb = "#{node['zabbix']['agent']['version']['linux']['deb']}#{node['lsb']['codename']}"

    # Add the the Zabbix repo to Debian systems.
    apt_repository 'zabbix' do
      uri "http://repo.zabbix.com/zabbix/#{zabbix_version_linux_repo_deb}/#{node['platform']}"
      distribution node['lsb']['codename']
      components ['main']
      deb_src true
      key "http://repo.zabbix.com/zabbix-official-repo.key"
      action :add
    end
    # Install the agent
    apt_package 'zabbix-agent' do
      version zabbix_version_linux_deb
      action :install
    end


  when 'rhel'
    zabbix_version_linux_repo_rhel = node['zabbix']['agent']['version']['linux']['repo']['rhel']
    zabbix_version_linux_rhel = node['zabbix']['agent']['version']['linux']['rhel']

    # Add the Zabbix repo to RHEL systems.
    yum_repository 'zabbix' do
      description 'Zabbix'
      baseurl "http://repo.zabbix.com/zabbix/#{zabbix_version_linux_repo_rhel}/rhel/7/$basearch/"
      gpgkey 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-A14FE591'
      enabled true
      gpgcheck true
      action :create
    end
    yum_repository 'zabbix-non-supported' do
      description 'Zabbix non-supported'
      baseurl "http://repo.zabbix.com/non-supported/rhel/7/$basearch/"
      gpgkey 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-A14FE591'
      enabled true
      gpgcheck true
      action :create
    end
    # Install the agent
    yum_package 'zabbix-agent' do
      version zabbix_version_linux_rhel
      action :install
    end

  end

  # Define the Zabbix agent service
  service node['zabbix']['agent']['service_name'] do
    action :nothing
  end

  # Generate the configuration file then notify the zabbix-agent service with a restart
  template node['zabbix']['agent']['conf_path'] do
    source 'zabbix_agentd.conf.erb'
    notifies :restart, "service[#{node['zabbix']['agent']['service_name']}]", :immediately
  end

else
  log 'zabbix_agent' do
    message "The platform : #{node['platform']} is not supported at this time."
    level :warn
  end
end