-- locat _M={}
-- 根据路由规则
-- 地址栏里面的 第一个斜杠后面的做完类名
-- 第二个斜杠后面的为方法名，默认是index
-- 
function dispach(class,method)
	-- print (class..method）
	local className = "c."..class
	local cc = require (className)
	
	-- ngx.print(type(cc))
	local bbb = cc[method]
	bbb()


end

