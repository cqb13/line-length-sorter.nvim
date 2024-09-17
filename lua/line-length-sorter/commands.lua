local sorter = require("line-length-sorter.sorter")

local function parse_args(args)
	local remove_blank = false
	if args and args:match("remove_blank=true") then
		remove_blank = true
	end
	return remove_blank
end

local function sort_longest_to_shortest_cmd(opts)
	local remove_blank = parse_args(opts.args)
	sorter.sort_longest_to_shortest(remove_blank)
end

local function sort_shortest_to_longest_cmd(opts)
	local remove_blank = parse_args(opts.args)
	sorter.sort_shortest_to_longest(remove_blank)
end

vim.api.nvim_create_user_command("SortLongestToShortest", sort_longest_to_shortest_cmd, { nargs = "*" })
vim.api.nvim_create_user_command("SortShortestToLongest", sort_shortest_to_longest_cmd, { nargs = "*" })

return {
	sort_longest_to_shortest_cmd = sort_longest_to_shortest_cmd,
	sort_shortest_to_longest_cmd = sort_shortest_to_longest_cmd,
}
