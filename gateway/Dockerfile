FROM kong:3.2.2
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001"
ENV KONG_DATABASE="off"
ENV KONG_DECLARATIVE_CONFIG="/app/kong.yml"
ENV KONG_LUA_PACKAGE_PATH="/app/plugins/auth_plugin/?.lua;;"
ENV KONG_PLUGINS="bundled,auth_plugin"
ARG SERVICE_EXCHANGE_HEADER_NAME
ARG SERVICE_EXCHANGE_KEY
ARG AUTH_PATH
ARG AUTH_SERVICE_URL
ARG USER_HEADER_NAME
EXPOSE 8000
EXPOSE 8001
USER 0

SHELL ["/bin/bash", "-c"]

RUN luarocks install lua-resty-jwt

COPY . /app
WORKDIR /app
RUN sed -e "s~{{ auth_service_url }}~${AUTH_SERVICE_URL}~g" \
        -e "s~{{ auth_path }}~${AUTH_PATH}~g" \
        -e "s~{{ service_exchange_header_name }}~${SERVICE_EXCHANGE_HEADER_NAME}~g" \
        -e "s~{{ service_exchange_key }}~${SERVICE_EXCHANGE_KEY}~g" \
        -e "s~{{ user_header_name }}~${USER_HEADER_NAME}~g" \
            kong.yml.template > kong.yml

RUN mkdir ./kong-runtime

CMD ["kong", "start", "-c", "kong.conf"]
