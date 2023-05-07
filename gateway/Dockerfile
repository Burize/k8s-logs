FROM kong:3.2.2
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001"
ENV KONG_DATABASE="off"
ENV KONG_DECLARATIVE_CONFIG="/app/kong.yml"
ENV KONG_LUA_PACKAGE_PATH="/app/plugins/auth_plugin/?.lua;;"
ENV KONG_PLUGINS="bundled,auth_plugin"
EXPOSE 8000
EXPOSE 8001
USER 0
RUN luarocks install lua-resty-jwt

COPY . /app
WORKDIR /app
RUN mkdir ./kong-runtime

CMD ["kong", "start", "-c", "kong.conf"]
