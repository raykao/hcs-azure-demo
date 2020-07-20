# https://learn.hashicorp.com/consul/hcs-azure/configuration

export subscription_id=<Your Azure subscription ID>
export resource_group=<The resource group>
export managed_app_name=<Your HCS on Azure instance name>
export cluster_name=<The name you gave to the Consul service>

# Get HCS Config
# https://learn.hashicorp.com/consul/hcs-azure/configuration
az resource show \
  --ids "/subscriptions/${subscription_id}/resourceGroups/${resource_group}/providers/Microsoft.Solutions/applications/${managed_app_name}/customconsulClusters/${cluster_name}" \
  --api-version 2018-09-01-preview -o json > hcs-config.json

cat consul_config.json | jq -r ".properties.consulConfigFile" | base64 --decode | jq -r > consul.json

cat ~/temp/output.json| jq -r ".properties.consulCaFile" | base64 --decode > ca.pem

# Place these into the consul config directory

# VNET Peer