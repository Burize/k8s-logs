local request = require "kong.plugins.auth_plugin.request"
local url = require "socket.url"
local cjson = require "cjson.safe"
local jwt = require "resty.jwt"
local module = {}

function build_request_url_to_auth_service(auth_service_url)
    local parsed_auth_service_url = url.parse(auth_service_url)
    local parsed_url = {
        scheme = kong.request.get_forwarded_scheme() or kong.request.get_scheme(),
        host = parsed_auth_service_url.host,
        port = parsed_auth_service_url.port,
        path = kong.request.get_path(),
    }
    return url.build(parsed_url)
end

function generate_jwt_token(jwt_credentials_url, jwt_payload, jwt_expiration_time)
     local ok, error, response = request.send(
            {
                url = jwt_credentials_url,
                method = 'GET',
            }
    )
    if error then
        return nil, error
    end

    local decoded_response = cjson.decode(response.body)

    local jwt_secret = decoded_response.data[1].secret
    local consumer_key = decoded_response.data[1].key
    local iat = os.time(os.date("!*t"))
    jwt_payload.iat = iat
    jwt_payload.exp = iat + jwt_expiration_time

    local jwt_token = {
        header = {
            typ='JWT',
            alg = 'HS256',
            iss = consumer_key,
        },
        payload = jwt_payload
    }

    local jwt_token_signed = jwt:sign(jwt_secret, jwt_token)

    return jwt_token_signed, nil

end

local function authenticate(config)
    local auth_request_url = build_request_url_to_auth_service(config.auth_service_url)
    local request_method = kong.request.get_method()
    local headers_to_send = kong.request.get_headers()

    -- copy "host" header from original request into "X-Forwarded-Host" and reset original "host" header to be
    -- auto-populated with target upstream service host to prevent multiple redirects:
    headers_to_send["X-Forwarded-Host"] = headers_to_send["host"]
    headers_to_send["host"] = nil
    headers_to_send[config.services_exchange_header_name] = string.format("Bearer %s", config.services_exchange_key)

    local payload = kong.request.get_raw_body()

    local ok, auth_error, auth_response = request.send(
            {
                url = auth_request_url,
                method = request_method,
                headers = headers_to_send,
                payload = payload
            }
    )

    if auth_error then
        kong.log('Failed to authenticate: ' .. tostring(auth_error))
        kong.response.error(auth_error.status, auth_error.message, auth_error.headers)
        return nil
    end

    kong.log(auth_response.body)
    local decoded_auth_response = cjson.decode(auth_response.body)
    local jwt_payload = {id = decoded_auth_response.id, email = decoded_auth_response.email }

   local token, jwt_token_error = generate_jwt_token(config.jwt_credentials_url, jwt_payload, config.jwt_expiration_time)

    if err then
        kong.log('Failed to generate jwt token: ' .. tostring(jwt_token_error))
        kong.response.error(jwt_token_error.status, jwt_token_error.message, jwt_token_error.headers)
    end

    kong.log(token)

    local response_body = {token = token}
    kong.response.exit(200, response_body)

end

function module.execute(config)
    local request_path = kong.request.get_path()
    local request_method = kong.request.get_method()

    kong.log(request_path)
    local is_path_to_loging = string.lower(request_path) == string.lower(config.auth_path)
    if not is_path_to_loging or request_method ~= 'POST' then
        return nil
    end

    authenticate(config)

end

return module