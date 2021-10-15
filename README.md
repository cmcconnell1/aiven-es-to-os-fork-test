# Aiven Elasticsearch (ES) to OpenSearch (OS) fork test

#### Overview
- This repo is for testing and validating the forking and deployment of the OS service and any existing dashboards, etc.
- Deploys 
  - one forked ES to OS cluster from the specified ES service to fork from
    - includes migrating/upgrading existing ES Kiband dashboards to OS Dashboards and data, etc.
  - one OS native (from scratch) cluster 

## Usage
- deploy the OS cluster(s)
```console
./bin/deploy-terraform-infra.sh

```
- destroys only the test/validation OS cluster(s) does not affect the specified existing ES cluster fork source.
```console
./bin/DESTROY-terraform-infra.sh
```

#### References:
- [Upgrading Elasticsearch services to Aiven for OpenSearch](https://help.aiven.io/en/articles/5424825-upgrading-elasticsearch-services-to-aiven-for-opensearch)
 - [Aiven Terraform Provider](https://github.com/aiven/terraform-provider-aiven)

#### Terraform Support for Migration Path 
- Project scope
  - Opensearch Resource (Aiven Terraform Provider)
    - test and validate the forking of existing Elasticsearch clusters and the deployment of new OpenSearch clusters.
    - allows customers to validate Kibana from ES to OpenSearch Dashboard Migrations
    - noting that The upgrade from Elasticsearch to OpenSearch will also upgrade your Kibana to OpenSearch Dashboards.


#### Validate OS data 
- Console
  - Navigate to the Aiven OS console: i.e.: 
    - https://public-mycluster-myproject.aivencloud.com/app/dev_tools#/console
        ```console
        GET _search
        {
          "query": {
            "match_all": {}
          }
        }

        GET _cat/indices
        GET _cluster/health
        GET _cluster/pending_tasks
        GET _cluster/settings
        GET _cluster/stats
        GET _nodes
        GET _cat/thread_pool
        ```

- Command line--note ensure requisite access model configured--i.e. VPC peering, or public access with CIDR allow list, etc.
```console
export ADMIN_PASSWORD="XXXXXXX"
export es="https://avnadmin:$ADMIN_PASSWORD@${SERVICE_NAME}-${PROJECT}.aivencloud.com:24947"

http $es
http $es/_cat/indices
http "$es/_cat/indices?bytes=b&s=store.size:desc&v"
http $es/_cat/nodes?h=ip,port,heapPercent,name
http $es/_cluster/health
http $es/_cluster/pending_tasks
http $es/_cluster/settings
http $es/_cluster/stats
http $es/_nodes
http $es/_cat/thread_pool
```