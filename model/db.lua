
local mysql = require "resty.mysql"

local MYSQL_INIT_SUCCESS=10000
local MYSQL_NEW_FAIL=10001
local MYSQL_CONNECT_FAIL =10002


local _db={
	instance=nil,

	config ={
	host = "127.0.0.1",
	port = 3306,
	database = "foo",
	user = "root",
	password = "root",
	max_packet_size = 1024 * 1024 }

}

--封装初始化
function _db.init(self) 
	
	local db, err = mysql:new()
	
	if not db then
		-- ngx.say("failed to instantiate mysql: ", err)
		return "",MYSQL_NEW_FAIL
	end

	db:set_timeout(1000) -- 1 sec



	local ok, err, errno, sqlstate = db:connect(self.config)

	if not ok then
		-- ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
		return "",MYSQL_CONNECT_FAIL
	end

	self.instance = db
		-- ngx.say("connected to mysql.")
	return "",MYSQL_INIT_SUCCESS
end
-- 查询
function _db.query(self, query )
	-- body
	-- ngx.print(query)

	res, err, errno, sqlstate =
                    self.instance:query(query, 10)
                if not res then
                    ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
                    return
                end
    -- for m, kk in pairs(res) do
    --                 ngx.print(m,kk.name,kk.id,  "<br/>")
    --             end
    local cjson = require "cjson"
                -- ngx.say("result: ", cjson.encode(res))  
    return cjson.encode(res)
end

return _db




-- ngx.say("bad result: ", res)

                -- local res, err, errno, sqlstate =
                --     db:query("drop table if exists cats")
                -- if not res then
                --     ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
                --     return
                -- end

                -- res, err, errno, sqlstate =
                --     db:query("create table cats "
                --              .. "(id serial primary key, "
                --              .. "name varchar(5))")
                -- if not res then
                --     ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
                --     return
                -- end

                -- ngx.say("table cats created.")

                -- res, err, errno, sqlstate =
                --     db:query("insert into cats (name) "
                --              .. "values (\'Bob\'),(\'\'),(null)")
                -- if not res then
                --     ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
                --     return
                -- end

                -- ngx.say(res.affected_rows, " rows inserted into table cats ",
                --         "(last insert id: ", res.insert_id, ")")

                -- -- run a select query, expected about 10 rows in
                -- -- the result set:
                -- res, err, errno, sqlstate =
                --     db:query("select * from cats order by id asc", 10)
                -- if not res then
                --     ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
                --     return
                -- end

                -- local cjson = require "cjson"
                -- ngx.say("result: ", cjson.encode(res))  
                -- ngx.say(type(res))
                -- -- for k,v in pairs
                -- for m, kk in pairs(res) do
                --     ngx.print(m,kk.name,kk.id,  "<br/>")
                -- end
                -- -- put it into the connection pool of size 100,
                -- -- with 10 seconds max idle timeout
                -- local ok, err = db:set_keepalive(10000, 100)
                -- if not ok then
                --     ngx.say("failed to set keepalive: ", err)
                --     return
                -- end