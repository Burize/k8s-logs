local typedefs = require "kong.db.schema.typedefs"


return {
  name = "auth_plugin",
  fields = {
    {
      -- this plugin will only be applied to Services or Routes
      consumer = typedefs.no_consumer
    },
    {
      -- this plugin will only run within Nginx HTTP module
      protocols = typedefs.protocols_http
    },
    {
            config = {
                type = "record",
                fields = {
                    { auth_service_url = typedefs.url({ required = true }), },
                    { auth_path = { type = "string", required = false} },
                    { protected_service_url = typedefs.url({ required = true }), },
                    { services_exchange_header_name = { type = "string", required = false, default = "X-SERVICE-EXHANGE-KEY" }, },
                    { services_exchange_key = {type = "string", required = false, default = '1400' }, },
                    { user_header_name = {type = "string", required = false, default = 'X-USER' }, },
                    { jwt_credentials_url = {type = "string", required = false, default = 'http://0.0.0.0:8001/consumers/authorized_user/jwt'}},
                    { jwt_expiration_time = {type = "number", required = false, default = 300000}},
                }
            },
        },
  },
}