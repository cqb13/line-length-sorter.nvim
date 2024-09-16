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
	else
		return lines
	end

	return filtered_lines
end

local function should_sort(lines)
	if #lines == 0 or #lines == 1 then
		return false
	end

	return true
end

local function write_lines(lines)
	local vstart = vim.fn.getpos("'<")
	local vend = vim.fn.getpos("'>")

	local line_start = vstart[2] - 1
	local line_end = vend[2]

	vim.api.nvim_buf_set_lines(0, line_start, line_end, false, lines)
end

local function sort_longest_to_shortest(remove_blank)
	local lines = get_selected_lines()

	if should_sort(lines) == false then
		return
	end

	local filtered_lines = filter_lines(lines, remove_blank)

	table.sort(filtered_lines, function(a, b)
		return #a > #b
	end)

	local sorted = filtered_lines

	write_lines(sorted)
end

local function sort_shortest_to_longest(remove_blank)
	local lines = get_selected_lines()

	if should_sort(lines) == false then
		return
	end

	local filtered_lines = filter_lines(lines, remove_blank)

	table.sort(filtered_lines, function(a, b)
		return #a < #b
	end)

	local sorted = filtered_lines

	write_lines(sorted)
end

return {
	sort_longest_to_shortest = sort_longest_to_shortest,
	sort_shortest_to_longest = sort_shortest_to_longest,
}
