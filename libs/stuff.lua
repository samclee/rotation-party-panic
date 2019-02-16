colors = {blue = {16/255, 173/255, 237/255}, 
			green = {192/255, 1, 51/255},
			orange = {1, 187/255, 17/255},
			purple = {176/255, 0, 181/255},
			pink = {250/255, 202/255, 222/255},
			powderblue = {170/255, 204/255, 238/255},
			mint = {211/255, 243/255, 200/255},
			beige = {241/255, 238/255, 206/255}
			}

function add(tbl, val)
	table.insert(tbl, val)
end

function del(tbl, val)
	table.remove(tbl, val)
end