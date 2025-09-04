local function setup_tera_injection(event)
	local bufnr = event.buf
	local filename = vim.fn.expand("%:t")

	vim.treesitter.stop(bufnr)

	local language = "html"

	local base_name = filename:match("(.+)%.tera$")
	if base_name then
		local ext = base_name:match("%.(%w+)$")
		if ext then
			language = ext
		end
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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWritePost" }, {
	pattern = "*.tera",
	callback = setup_tera_injection,
	desc = "Setup TreeSitter injection for .tera files",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tera",
	callback = setup_tera_injection,
	desc = "Setup TreeSitter injection for tera filetype",
})
