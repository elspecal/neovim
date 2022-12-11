if not vim.filetype then
	return
end

vim.filetype.add({
  extension = {
    html = function(path, bufnr)
      if string.match(path, "/templates/") then
        return "htmldjango"
      end
      return "html"
    end,
  },
	--[[ pattern = {
		['.*/templates/.*%.html'] = "htmldjango",
	}, ]]
})
