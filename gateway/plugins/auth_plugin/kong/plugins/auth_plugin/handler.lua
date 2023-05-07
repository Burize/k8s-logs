local access = require "kong.plugins.auth_plugin.access"

local JWT_PLUGIN_PRIORITY = 1500

local AuthPluginHandler = {
  VERSION  = "1.0.0",
  PRIORITY = JWT_PLUGIN_PRIORITY + 1,
}


function AuthPluginHandler:access(config)
  access.execute(config)
end


return AuthPluginHandler