local function get_selected_lines()
	local vstart = vim.fn.getpos("'<")

	local vend = vim.fn.getpos("'>")

	local line_start = vstart[2]
	local line_end = vend[2]

	local lines = vim.fn.getline(line_start, line_end)

	return lines
end

local function filter_lines(lines, remove_blank)
	local filtered_lines = {}

	if remove_blank == true or remove_blank == nil then
		for _, line in pairs(lines) do
			if line ~= "" then
				filtered_lines[#filtered_lines + 1] = line
			end
		end
	end

	return filtered_lines
end

local function should_sort(lines)
	if lines == nil or type(lines) == "string" then
		return false
	end

	if type(lines) == "table" and #lines == 0 then
		return false
	end

	return true
end

local function sort_longest_to_shortest(include_comments, remove_blank)
	local lines = get_selected_lines()

	if should_sort == false then
		return
	end

	local filtered_lines = filter_lines(lines, remove_blank)

	table.sort(filtered_lines, function(a, b)
		return #a > #b
	end)

	local sorted = filtered_lines

	vim.print(sorted)
end

local function sort_shortest_to_longest(include_comments, remove_blank)
	local lines = get_selected_lines()

	if should_sort == false then
		return
	end

	local filtered_lines = filter_lines(lines, remove_blank)

	table.sort(filtered_lines, function(a, b)
		return #a < #b
	end)

	local sorted = filtered_lines

	vim.print(sorted)
end

return {
	sort_longest_to_shortest = sort_longest_to_shortest,
	sort_shortest_to_longest = sort_shortest_to_longest,
}
