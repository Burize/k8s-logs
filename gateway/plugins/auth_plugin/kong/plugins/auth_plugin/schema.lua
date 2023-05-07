local typedefs = require "kong.db.schema.typedefs"


return {
  name = "auth_plugin",
  fields = {
    {
      -- This plugin will only be applied to Services or Routes
      consumer = typedefs.no_consumer
    },
    {
      protocols = typedefs.protocols_http
    },
    {
            config = {
                type = "record",
                fields = {
                    { auth_service_url = typedefs.url({ required = true }), },
                    { auth_path = { type = "string", required = true} },
                    { protected_service_url = typedefs.url({ required = true }), },
                    { services_exchange_header_name = { type = "string", required = true }, },
                    { services_exchange_key = {type = "string", required = true }, },
                    { user_header_name = {type = "string", required = true }, },
                    { jwt_credentials_url = {type = "string", required = true}},
                    { jwt_expiration_time = {type = "number", required = false, default = 300000}},
                }
            },
        },
  },
}