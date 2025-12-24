local git_ref = "7e1cd7703ff2924d7038476dcbc04b950203b902"
local modrev = "scm"
local specrev = "1"

local repo_url = "https://github.com/stevearc/oil.nvim"

rockspec_format = "3.0"
package = "oil.nvim"
version = modrev .. "-" .. specrev

description = {
	summary = "Neovim file explorer: edit your filesystem like a buffer",
	detailed = "",
	labels = { "neovim" },
	homepage = "https://github.com/stevearc/oil.nvim",
	license = "MIT",
}

dependencies = { "lua >= 5.1" }

test_dependencies = {}

source = {
	url = repo_url .. "/archive/" .. git_ref .. ".zip",
	dir = "oil.nvim-" .. git_ref,
}

if modrev == "scm" or modrev == "dev" then
	source = {
		url = repo_url:gsub("https", "git"),
	}
end

build = {
	type = "builtin",
	copy_directories = { "doc", "syntax" },
}
