local function setup_tera_injection()
	local data_path = vim.fn.stdpath("data")
	local tera_dir = data_path .. "/tera-autoextsyn"
	local queries_dir = tera_dir .. "/queries"
	local tera_queries_dir = queries_dir .. "/tera"
	local injections_file = tera_queries_dir .. "/injections.scm"

	vim.fn.mkdir(tera_queries_dir, "p")

	local rtp = vim.o.runtimepath
	if not rtp:find(tera_dir, 1, true) then
		vim.o.runtimepath = rtp .. "," .. tera_dir
	end

	local bufname = vim.api.nvim_buf_get_name(0)
	local filename = vim.fn.fnamemodify(bufname, ":t")

	local pattern = "(.+)%.tera$"
	local base_name = filename:match(pattern)

	local ext = base_name:match("%.(%w+)$")
	local language = ext or "html"

	local injection_content = string.format(
		[[; extends

((content) @injection.content
  (#set! injection.language "%s")
  (#set! injection.combined))]],
		language
	)

	local file = io.open(injections_file, "w")
	if file then
		file:write(injection_content)
		file:close()
	else
		vim.print("Failed to create injections.scm file", vim.log.levels.ERROR)
		return
	end

	vim.cmd("TSBufDisable highlight")
	vim.cmd("TSBufEnable highlight")
end

-- Create the autocommand
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tera",
	callback = setup_tera_injection,
	desc = "Setup TreeSitter injection for .tera files and update runtimepath",
})
