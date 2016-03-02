# openshift-apache-php

Template for running a apache php on a container based on alpine linux/openshift/docker.

### Installation

You need oc (https://github.com/openshift/origin/releases) locally installed:

create a new project (change to your whishes) or add this to your existing project

```sh
oc new-project openshift-apache-php \
    --description="WebServer - Apache PHP" \
    --display-name="Apache PHP"
```

Deploy (externally)

```sh
oc new-app https://github.com/weepee-org/openshift-apache-php.git --name apache-php
```

Deploy (weepee internally)
add to Your buildconfig
```yaml
spec:
  strategy:
    dockerStrategy:
      from:
        kind: ImageStreamTag
        name: php-webserver:latest
        namespace: weepee-registry
    type: Docker
```
use in your Dockerfile
```sh
FROM weepee-registry/php-webserver

# Your app
ADD app /app
```

#### Route.yml

Create route for development and testing

```sh
curl https://raw.githubusercontent.com/ure/openshift-apache-php/master/Route.yaml | oc create -f -
```
