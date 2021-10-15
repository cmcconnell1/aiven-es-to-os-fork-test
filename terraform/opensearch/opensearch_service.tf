# Test / validation for Elasticsearch to OpenSearch using Aiven
# Forked Elasticsearch (ES) to OpenSearch (OS) deployment
# Notes: 
#   does not alter existing ES instance--only forks from it to deploy new OS service
#   the fork/upgrade from ES to OS also upgrades and migrates Kibana to OS Dashboards
resource "aiven_opensearch" "os" {
  project = "customer-demo"
  cloud_name = "azure-eastus"
  plan = "startup-4"
  service_name = "customer-os-test"
  maintenance_window_dow = "monday"
  maintenance_window_time = "10:00:00"

  opensearch_user_config {
    opensearch_version = 1

    # we enable OS dashboards
    opensearch_dashboards {
      enabled = true
      opensearch_request_timeout = 30000
    }

    # control the OS dashboards access model/paramaters here
    public_access {
      opensearch = true
      opensearch_dashboards = true
    }

  # if forking from existing ES service--which service
  service_to_fork_from = "es-customer-test"
  # if forking from existing ES--from which project
  project_to_fork_from = "customer-demo"

  }
}

## Optionally we could add an Opensearch user 
# in this example, we add a new user for accessing the OS service data 
# to the newly deployed, forked Elasticsearch to OpenSearch cluster
resource "aiven_service_user" "os-user" {
  project = "customer-demo"
  service_name = aiven_opensearch.os.service_name
  username = "test-user1"
}

# Native OpenSearch deployment: a new OS cluster from scratch
resource "aiven_opensearch" "osnative" {
  project = "customer-demo"
  cloud_name = "azure-eastus"
  plan = "startup-4"
  service_name = "customer-os-native"
  maintenance_window_dow = "monday"
  maintenance_window_time = "10:00:00"

  opensearch_user_config {
    # latest version 1.0.0 as of 2021-10-15
    # ref: https://aiven.io/opensearch
    opensearch_version = 1

    opensearch_dashboards {
      enabled = true
      opensearch_request_timeout = 30000
    }

    public_access {
      opensearch = true
      opensearch_dashboards = true
    }

  }
}
