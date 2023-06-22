# Adding a New Service to the Infrastructure

This document outlines the steps to follow when adding a new service to the existing infrastructure. Please ensure that you have the necessary permissions and access to the infrastructure components before proceeding.
## Prerequisites

Before you begin, make sure you have the following prerequisites in place:

    Docker Compose: Ensure that Docker Compose is installed on your machine.

    Access to Configuration Files: Obtain access to the necessary configuration files, including the Traefik dynamic configuration file.

## Steps

Follow these steps to add a new service to the infrastructure:

* Create a Docker Compose File:
    * Create a new Docker Compose file (e.g., docker-compose.yml) in the desired directory.
    * Define the service configuration in the Docker Compose file, specifying the necessary image, environment variables, ports, volumes, etc., as per your service requirements.
    * Save the Docker Compose file.

* Add Service to proxynet Network:
    * Open the existing docker-compose.yml file that defines the infrastructure services.
    * Add the new service to the `proxynet` network under the networks section of the service configuration.
    * Save the docker-compose.yml file.

* Add `http.routers.<servicename>` Entry in Dynamic Traefik Configuration:
    * Open the Traefik dynamic configuration file (e.g., dynamic_conf.toml).
    * Add a new entry under the http.routers section to configure the routing for the new service.
    * Define the appropriate rules, including the entry points, middlewares, and service configuration.
    * Save the Traefik dynamic configuration file.

* (Optional) Add `<http.service>` Traefik Port Mapping:
    * If the new service requires a specific port mapping in Traefik, open the Traefik dynamic configuration file.
    * Add a new entry under the http.services section to define the mapping for the new service.
    * Specify the service name and the corresponding port where the service is exposed (e.g., http.backend:3000).
    * Save the Traefik dynamic configuration file.

* Add CNAME record for subdomain to DNS service  

* Check firewall, e.g. fritz.box settings, to allow traffic of given URL.

* Start the New Service Stack:
    * Open a terminal or command prompt and navigate to the directory where the new Docker Compose file is located.
    * Run the command docker-compose up to start the new service stack.
    * Monitor the logs for any errors or issues during the startup process.
    * Verify that the new service is running and accessible as expected.
