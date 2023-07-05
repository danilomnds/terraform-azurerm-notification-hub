# Module - Notification Hub
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the Notification Hub Namespace and Hub creation.

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.5.2            | 3.63.0          |

## Specifying a version

To avoid that your code get updates automatically, is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can define the version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case

```hcl
module "<ntfns-name>" {
  source = "git::https://github.com/danilomnds/terraform-azurerm-notification-hub?ref=v1.0.0"
  namespace_name = "<ntfns-name>"
  location = "<location>"
  resource_group_name  = "<resource-group-name>"
  namespace_type = "<Messaging/NotificationHub>"  
  sku_name = "<Free/Basic/Standard>"
  tags = {
    "key1" = "value1"
    "key2" = "value2"    
  }
  # optional (creation of the eventhub)
  hubs_parameters = {
    <nft-env-system> = {
      name = <nft-env-system>
    }
    <nft-env-system2> = {
      name = <nft-env-system2>
    }
  }
  azure_ad_groups = ["group id 1"]
}
output "ntfns_name" {
  value = module.<ntfns-name>.name
}
output "ntfns_id" {
  value = module.<ntfns-name>.id
}

output "ntf_hubs" {
  value = module.<ntfns-name>.hubs
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| namespace_name | notification hub namespace name | `string` | n/a | `Yes` |
| location | azure region | `string` | n/a | `Yes` |
| resource_group_name | resource group where the resources will be created | `string` | n/a | `Yes` |
| namespace_type | the type of namespace | `string` | n/a | `Yes` |
| sku | The name of the SKU to use for this Notification Hub Namespace | `string` | n/a | `Yes` |
| enabled | is this notification hub namespace enabled? | `bool` | `true` | No |
| tags | tags for the resource | `map(string)` | `{}` | No |
| hubs_parameters | hubs specifications | `list(object{})` | `[]` | No |
| azure_ad_groups | list of azure AD groups that will have access to the resources  | `list` | `[]` | No |

## Object variables

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| hubs_parameters | name | the name to use for this notification hub | `map(object(string))` | n/a | `Yes` |
| hubs_parameters | apns_credential (block) application_mode | the application mode which defines which server the apns messages should be sent to | `map(object(optional(object(string)))))` | n/a | `Yes` |
| hubs_parameters | apns_credential (block) bundle_id | the bundle id of the ios/macos application to send push notifications for | `map(object(optional(object(string)))))` | n/a | `Yes` |
| hubs_parameters | apns_credential (block) key_id | the apple push notifications service (apns) key | `map(object(optional(object(string)))))` | n/a | `Yes` |
| hubs_parameters | apns_credential (block) team_id | the id of the team the token | `map(object(optional(object(string)))))` | n/a | `Yes` |
| hubs_parameters | apns_credential (block) token | the push token associated with the apple developer account | `map(object(optional(object(string)))))` | n/a | `Yes` |
| hubs_parameters | gcm_credential (block) api_key | the api key associated with the google cloud messaging service | `map(object(optional(object(string)))))` | n/a | `Yes` |


## Output variables

| Name | Description |
|------|-------------|
| name | notification hub namespace name |
| id | notification hub namespace id |
| hubs | hub's ids |

## Documentation

Terraform Notification Hub Namespace: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub)<br>

Terraform Notification Hub: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/notification_hub)<br>
