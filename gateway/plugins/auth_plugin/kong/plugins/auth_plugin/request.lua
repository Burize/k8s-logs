local http = require "resty.http"
local module = {}


function module.send(args)
    local url = args.url
    local method = args.method or "GET"
    local headers = args.headers
    local timeout = args.timeout or 30 * 1000
    local payload = args.payload or {}

    local httpc = http.new()
    httpc:set_timeout(timeout)

    local res, err = httpc:request_uri(
        url,
        {
            method = method,
            headers = headers,
            body = payload,
        }
    )

    if not res then
        return false, "failed request to " .. url .. ": " .. (err or "")
    end

    local response = {
        status = res.status,
        headers = res.headers,
        body = res.body
    }

    local success = res.status < 400
    local err_msg
    if not success then
        err_msg = "request to " .. url .. " returned status code = " .. tostring(res.status)
        kong.log.debug("Request was not successful: ", err_msg .. " and body = " .. tostring(response.body))
    end

    return success, err_msg, response
end


return module;
