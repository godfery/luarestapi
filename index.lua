-- 入口类 ,根据入口规则分发，完成简单的mvc结构。





local lib = require("lib.lib")
require "lib.core"

if not lib then
    ngx.say("Failed to require lib!")
    return
end 
local router = require 'lib.router'
local r = router.new()





local uri = ngx.var.uri
-- ngx.print(uri)
-- 
local uriPath = lib:explode(uri,'/')



local switch = {
    [1] = function()    -- for case 1
        -- ngx.print("Case 1.")
        dispach(uriPath[1],"index")
    end,
    [2] = function()    -- for case 2
        dispach(uriPath[1],uriPath[2])
    end,
    [0] = function()    -- for case 3
        ngx.status = 404
        ngx.print("Not found!")
        

    end
}


local f = switch[table.getn(uriPath)]
if(f) then
    f()
else                -- for case default
    local ok, errmsg = r:execute(
        ngx.var.request_method,
        "/",
        ngx.req.get_uri_args())
    if ok then
        ngx.status = 200
    else
        ngx.status = 404
        ngx.print("Not found!")
        -- ngx.print(ngx.ERROR, errmsg)
    end    
end
-- require "print_param"