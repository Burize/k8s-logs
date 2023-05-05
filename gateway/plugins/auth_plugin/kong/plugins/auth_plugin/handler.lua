local access = require "kong.plugins.auth_plugin.access"

local AuthPluginHandler = {
  VERSION  = "1.0.0",
  PRIORITY = 1451,
}


function AuthPluginHandler:access(config)
  access.execute(config)
end


return AuthPluginHandler