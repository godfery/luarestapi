local _M = {}
function _M.test()
    ngx.say("call  a!")
end

function _M.b() 
	ngx.say("call  b!")
end

return _M