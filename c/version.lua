
local _version={}
-- 版本检查
function _version.index() 

        
    local mysql = require "model.db"


    local ok,status = mysql:init();
    if status ~=10000 then
        ngx.say("error was happened")    
    return
    end 
    local res = mysql:query("select * from cats order by id asc")
    -- ngx.say(res)
    -- for m, kk in pairs(res) do
    --                 ngx.print(m,kk.name,kk.id,  "<br/>")
    --             end
    local cjson = require "cjson"
    -- ngx.say("result: ", cjson.encode(res))  

    for m, kk in pairs(cjson.decode(res)) do
        ngx.print(m,kk.name,kk.id,  "<br/>")
    end

end

return _version