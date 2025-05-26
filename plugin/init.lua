local function setup_tera_injection(event)
	local bufnr = event.buf
	local filename = vim.fn.fnamemodify(event.match, ":t")

	vim.treesitter.stop(event.buf)

	local language = "html"
	local pattern = "(.+)%.tera$"
	local base_name = filename:match(pattern)

	local ext = base_name:match("%.(%w+)$")
	if ext then
		language = ext
	else
		language = "html"
	end

	local injection_query = string.format(
		[[((content) @injection.content
  (#set! injection.language "%s")
  (#set! injection.combined))]],
		language
	)
	vim.treesitter.query.set("tera", "injections", injection_query)

	vim.treesitter.start(bufnr)
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tera",
	callback = setup_tera_injection,
	desc = "Setup TreeSitter injection for .tera files",
})
