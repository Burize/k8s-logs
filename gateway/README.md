# API Gateway
This is API gateway written in Lua using [Kong Gateway](https://konghq.com/products/kong-gateway).
Kong provides a lot of features, such as traffic management and transformations, security, observability and the rest. 
Most of these features are provided by [Plugins](https://docs.konghq.com/hub/). You can use one of the existing plugins or write your own.

This Gateway uses two plugins provided by Kong: [jwt](https://docs.konghq.com/hub/kong-inc/jwt/) and [request-transformer](https://docs.konghq.com/hub/kong-inc/request-transformer/), and own [auth_plugin](plugins/auth_plugin) placed in this repository.
You can see their settings in `kong.yml.template` file.

### Auth plugin
Auth plugin is placed before JWT plugin. 
If request doesn't have a valid JWT token, JWT plugin doesn't forward this request further to an upstream service, which is the protected rest API according to this repository.

The purpose of Auth plugin is to check, if request has path equal to `auth_path` config variable and if so then redirect it to an auth service.
If a response from auth service is successfull, then Auth plugin generates valid JWT token and returns it to a user.
So they can make further requests with this JWT token in Authorization header.
If request has path, that isn't equal to `auth_path` config variable, then plugin just forwards this request to upstream.
In our case, it forwards request to JWT plugin.

You can read more about custom plugins [there](https://docs.konghq.com/gateway/latest/plugin-development/).

### Run service
Set appropriate values in the args section in `docker-compose.yml`:
- `AUTH_SERVICE_URL` - url to the auth service;
- `AUTH_PATH` - endpoint in the auth service, which authenticate a user;
- `PROTECTED_SERVICE_HOST` and `PROTECTED_SERVICE_PORT` - host and port of the protected service;
- `USER_HEADER_NAME` - name of http header, which contains JWT token. Should be the same as in the protected service;
- `SERVICE_EXCHANGE_HEADER_NAME` and `SERVICE_EXCHANGE_KEY` - http header name for and value of service exchange key. These values should be the same as in auth and protected services.

Run `docker compose up` to build and start kong container. 

Container for database is not needed, because the DB-less mode is used here.
You can read more about kong installation [there](https://docs.konghq.com/gateway/latest/install/docker).

After that, Gateway is available on `http://127.0.0.1:8000`. 

You can make request to authenticate a user:
```
curl -X POST 'http://127.0.0.1:8000/{AUTH_PATH}' -H 'Content-Type: application/json' --data '{"username": "test_1", "password": "123"}'
```
_User with this username and password should be created in the auth service_

Then make request to the protected endpoint using gotten JWT token:
```
curl -X GET -H "X-SERVICE-EXCHANGE-KEY:Bearer SERVICE_EXCHANGE_SECRET_KEY" -H "Authorization:Bearer {JWT_TOKEN}"  https://127.0.0.1:8000/api/user/
```

### Bulding docker image
`kong.yml` file is config for Kong Gateway.
It describes what plugins are used, upstream services that need to forward requests and the rest.
It's generated during image build, so need to specify appropriate values in [build args](https://docs.docker.com/build/guide/build-args/).
Locally docker image is build via `docker compose`, so you can specify all args in `docker-compose.yml`.
However, when need to build image in a cloud, then `docker compose` usually isn't used, and `docker build ...` command is used instead.

This service is intented to be deployed to Google cloud, so need to build docker image for gateway and store it in the Google Artifact Registry.

It can be done with this command:
```
gcloud builds submit --substitutions=_SERVICE_EXCHANGE_HEADER_NAME="X-SERVICE-EXCHANGE-KEY",_SERVICE_EXCHANGE_KEY="SERVICE_EXCHANGE_SECRET_KEY",_AUTH_PATH="/api/authenticate",_AUTH_SERVICE_URL="http://auth-service-api:8083",_USER_HEADER_NAME="X-USER",PROTECTED_SERVICE_HOST="protected-service-api",_PROTECTED_SERVICE_PORT="3000" --config cloudbuild.yaml .
```

As you can see this command uses `cloudbuild.yaml` file as config and set appropriate values for docker build args via `substitutions` parameter.

You can read more about building images for Google Cloud at these links:
- https://cloud.google.com/build/docs/build-push-docker-image
- https://cloud.google.com/build/docs/configuring-builds/substitute-variable-values