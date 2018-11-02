# zabbix_agent_lite

Installs and configures the Zabbix agent with minimal cookbook dependencies.

---

## Supports:

* Ubuntu
* Debian
* RedHat
* CentOS
* Windows - via Chocolatey

## Usage

### zabbix_agent::default

Just include `zabbix_agent_lite` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zabbix_agent_lite]"
  ]
}
```

## Attributes 

To configure the agent conf file add options to the `['zabbix']['agent']['config']` object and they'll be dumped into the conf file.

For other attributes take a look at the default attributes file.