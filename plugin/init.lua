local group = vim.api.nvim_create_augroup("TeraSyntaxInjection", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
	group = group,
	pattern = "*.tera",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		local filename = vim.fn.expand("%:t")

		local underlying_filetype = filename:match("%.([^%.]+)%.tera$") or "html"

		if underlying_filetype == "tera" then
			underlying_filetype = "html"
		end

		vim.bo[bufnr].filetype = "tera"
	end,
})

