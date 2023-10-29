require("nvim-treesitter").setup({
  ensure_installed = {
    "bash",
    "c",
    "json",
    "lua",
    "typescript",
    "tsx",
    "css",
    "rust"
  },
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	indent = { enable = true, disable = { "python", "css" } },
})
