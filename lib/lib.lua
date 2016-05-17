local _M = {}
function _M.test()
    ngx.say("hello test!")
end
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end
-- 类似php的explode
-- 第二个参数为格式
function _M.explode(self,pp,delim)
    local t={}
    -- local ppp = pp:split(delim)
    -- ngx.print(type(pp))
    -- ngx.say("explode : ",  "<br/>")
    if type(pp) == "table" then

        for m, kk in pairs(pp) do
            ngx.print(m,  "<br/>")
        end
    else 

    	-- ngx.print
        -- ngx.say("explode : ", pp, "<br/>")
        if pp ~=nil then 
			     t = split(pp,'[\\/]+')
        end
	    
    end
    
    return t
end
-- body

return _M