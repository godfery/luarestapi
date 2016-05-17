
ngx.print("<br/>","---------*****************************----------------print_param","<br/>")

local headers = ngx.req.get_headers()
-- echo("fdsf"..headers)

ngx.say("headers begin", "<br/>")
ngx.say("Host : ", headers["Host"], "<br/>")
ngx.say("user-agent : ", headers["user-agent"], "<br/>")
ngx.say("user-agent : ", headers.user_agent, "<br/>")
ngx.say("user-agent : ", ngx.var.uri, "<br/>")




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

-- function router(u,t,_p)
--     local f,p = _router(u,t,_p)
--     if f then
--         f(p)
--         return true
--     elseif p then
--         local e = nil
--         if on_start then e = on_start() end
--         if not e then
--             local r,e = dofile(_p..p)
--             if e then
--                 header('HTTP/1.1 503 Server Error')
--                 header('Content-Type: text/html; charset=UTF-8')
--                 print_error(e)
--                 die()
--             end
--         end

--         return true
--     else
--         return nil
--     end
-- end
-- _router = router
-- routes['^/(.*).(jpg|gif|png|css|js|ico|swf|flv|mp3|mp4|woff|eot|ttf|otf|svg)$'] = function()
--     header('Cache-Control: max-age=864000')
--     if headers.uri:find('.js',1,1) or headers.uri:find('.css',1,1) then -- cloud be gzip
--         local mtime = filemtime(headers.uri)
--         if headers['if-none-match'] and tonumber(headers['if-none-match']) == mtime then
--             header('HTTP/1.1 304 Not Modified')
--         else
--             header('Etag: '..mtime)
--             echo(readfile(headers.uri))
--         end
--     else
--         sendfile(headers.uri)
--     end
-- end

-- routes['^/user/:user_id'] = function(r)
--     echo('User ID: ', r.user_id)
-- end

-- routes['^/user/:user_id/:post(.+)'] = function(r)
--     echo('User ID: ', r.user_id)
--     echo(' Post: ', r.post)
-- end

-- routes['^/(.*)'] = function(r)
--     dofile('/index.lua')
-- end

-- --[[
-- others you want :)
-- ]]

-- -- if the 3rd argument is a path, then router will try to get local lua script file first
-- if not router(ngx.var.uri, routes, '/') then
--     header('HTTP/1.1 404 Not Found')
--     ngx.say('File Not Found!')
-- end