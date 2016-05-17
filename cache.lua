local redis = require "resty.redis"

local cache = redis.new()

local ok, err = cache.connect(cache, '127.0.0.1', '6379')

cache:set_timeout(60000)

if not ok then
        ngx.say("failed to connect:", err)
        return
end

res, err = cache:set("dog", "an aniaml")
if not ok then
        ngx.say("failed to set dog: ", err)
        return
end

ngx.say("set result: ", res)

local res, err = cache:get("dog")
if not res then
        ngx.say("failed to get dog: ", err)
        return
end

if res == ngx.null then
        ngx.say("dog not found.")
        return
end

ngx.say("dog: ", res)


local ok, err = cache:close()
ngx.say(ok)
if not ok then
	ngx.say("fail to close")

end


--nginx变量
local var = ngx.var
ngx.say("ngx.var.a : ", var.a, "<br/>")
ngx.say("ngx.var.b : ", var.b, "<br/>")
ngx.say("ngx.var[2] : ", var[2], "<br/>")
-- ngx.var.b = 2;

ngx.say("<br/>")

--请求头
local headers = ngx.req.get_headers()
ngx.say("headers begin", "<br/>")
ngx.say("Host : ", headers["Host"], "<br/>")
ngx.say("user-agent : ", headers["user-agent"], "<br/>")
ngx.say("user-agent : ", headers.user_agent, "<br/>")
for k,v in pairs(headers) do
    if type(v) == "table" then
        ngx.say(k, " : ", table.concat(v, ","), "<br/>")
    else
        ngx.say(k, " : ", v, "<br/>")
    end
end
ngx.say("headers end", "<br/>")
ngx.say("<br/>")

--get请求uri参数
ngx.say("uri args begin", "<br/>")
local uri_args = ngx.req.get_uri_args()
for k, v in pairs(uri_args) do
    if type(v) == "table" then
        ngx.say(k, " : ", table.concat(v, ", "), "<br/>")
    else
        ngx.say(k, ": ", v, "<br/>")
    end
end
ngx.say("uri args end", "<br/>")
ngx.say("<br/>")

--post请求参数
ngx.req.read_body()
ngx.say("post args begin", "<br/>")
local post_args = ngx.req.get_post_args()
for k, v in pairs(post_args) do
    if type(v) == "table" then
        ngx.say(k, " : ", table.concat(v, ", "), "<br/>")
    else
        ngx.say(k, ": ", v, "<br/>")
    end
end
ngx.say("post args end", "<br/>")
ngx.say("<br/>")

--请求的http协议版本
ngx.say("ngx.req.http_version : ", ngx.req.http_version(), "<br/>")
--请求方法
ngx.say("ngx.req.get_method : ", ngx.req.get_method(), "<br/>")
--原始的请求头内容
ngx.say("ngx.req.raw_header : ",  ngx.req.raw_header(), "<br/>")
--请求的body内容体
ngx.say("ngx.req.get_body_data() : ", ngx.req.get_body_data(), "<br/>")
ngx.say("<br/>")


-- local http = require("resty.http")
-- --创建http客户端实例
-- local httpc = http.new()

-- local resp, err = httpc:request_uri("http://s.taobao.com", {
--     method = "GET",
--     path = "/search?q=hello",
--     headers = {
--         ["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36"
--     }
-- })

-- if not resp then
--     ngx.say("request error :", err)
--     return
-- end

-- --获取状态码
-- ngx.status = resp.status

-- --获取响应头
-- for k, v in pairs(resp.headers) do
--     if k ~= "Transfer-Encoding" and k ~= "Connection" then
--         ngx.header[k] = v
--     end
-- end
-- --响应体
-- ngx.say(resp.body)

-- httpc:close()
-- if not ok then
--         ngx.say("failed to close:", err)
--         return
-- end