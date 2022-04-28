-- general
lvim.leader = "space"
lvim.log.level = "warn"
lvim.colorscheme = "tokyonight"
lvim.format_on_save = false
lvim.transparent_window = true

-- native
vim.opt.cmdheight = 1
vim.opt.smartindent = false
vim.opt.relativenumber = true
vim.opt.cursorline = false

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = "/home/aaronsms/.local/share/pyenv/versions/py3nvim/bin/python3"

vim.g.nord_contrast = true
vim.g.tokyonight_style = "night"
vim.g.gruvbox_contrast_dark = "medium"
vim.g.cmp_toggle_flag = true

-- vim.g.slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait &"
-- vim.g.slimv_lisp = "ros run"
-- vim.g.slimv_impl = "sbcl"

-- keymappings
lvim.keys.normal_mode["Y"] = { "y$", { noremap = true } }
lvim.keys.visual_mode["y"] = { "mzy`z", { noremap = true } }
lvim.keys.normal_mode["n"] = { "nzzzv", { noremap = true } }
lvim.keys.normal_mode["N"] = { "Nzzzv", { noremap = true } }
lvim.keys.normal_mode["J"] = { "mzJ`z", { noremap = true } }
lvim.keys.insert_mode[","] = { ",<c-g>u", { noremap = true } }
lvim.keys.insert_mode["."] = { ".<c-g>u", { noremap = true } }
lvim.keys.insert_mode["!"] = { "!<c-g>u", { noremap = true } }
lvim.keys.insert_mode["?"] = { "?<c-g>u", { noremap = true } }
lvim.keys.normal_mode["k"] = { '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true, noremap = true } }
lvim.keys.normal_mode["j"] = { '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true, noremap = true } }
lvim.keys.visual_mode["J"] = "J"
lvim.keys.visual_mode["K"] = "K"

lvim.keys.insert_mode["j"] = { "j", { noremap = true } }
lvim.keys.insert_mode["k"] = { "k", { noremap = true } }

vim.g.copilot_no_tab_map = true
vim.cmd([[imap <silent><script><expr> <C-A-n> copilot#Accept("\<CR>")]])

lvim.keys.normal_mode["tt"] = { "<cmd>TroubleToggle<cr>", { noremap = true } }
lvim.keys.normal_mode["ts"] = { "<cmd>setlocal spell!<cr>", { noremap = true } }
lvim.keys.normal_mode["tl"] = { "<cmd>setlocal list!<cr>", { noremap = true } }
lvim.keys.normal_mode["tg"] = { "<cmd>Goyo<cr>", { noremap = true } }
lvim.keys.normal_mode["tc"] = { "<cmd>lua vim.g.cmp_toggle_flag=not vim.g.cmp_toggle_flag<cr>", { noremap = true } }

lvim.keys.normal_mode["<c-f>"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true } }
lvim.keys.normal_mode["<c-s>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true } }

lvim.keys.normal_mode["<Space>1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { noremap = true } }
lvim.keys.normal_mode["<Space>2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { noremap = true } }
lvim.keys.normal_mode["<Space>3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { noremap = true } }
lvim.keys.normal_mode["<Space>4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { noremap = true } }

lvim.keys.normal_mode["<Space>9"] = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { noremap = true } }
lvim.keys.normal_mode["<Space>0"] = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", { noremap = true } }

-- autocommands
lvim.autocommands.text_files = {
	{ "BufNewFile,BufFilePre,BufRead", "*.md", "setlocal filetype=markdown.pandoc" },
	{
		"BufNewFile,BufFilePre,BufRead",
		"*.md,*.tex,*.txt",
		"setlocal textwidth=79 | setlocal spell",
	},
}

-- core plugins
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>Telescope grep_string<CR>", "Grep string" }
lvim.builtin.which_key.mappings["T"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics" },
}

lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.cmp.enabled = function()
	return vim.g.cmp_toggle_flag
end

local _, actions = pcall(require, "telescope.actions")
require("telescope").load_extension("harpoon")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- -- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-c>"] = actions.close,
	},
}

lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.alpha.active = false
lvim.builtin.dap.active = true

-- LSP settings
lvim.lsp.automatic_servers_installation = true
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "volar" })

-- manually setup a server
-- local opts = {}
-- require("lvim.lsp.manager").setup("volar", opts)

-- custom on_attach function for all the language servers
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "black", filetypes = { "python" } },
	{ command = "isort", filetypes = { "python" } },
	{ command = "stylua", filetypes = { "lua" } },
	{
		-- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "prettier",
		filetypes = { "typescript", "vue" },
		-- extra_args = { "--print-with", "100" },
	},
})

-- set linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	{ command = "eslint", filetypes = { "typescript" } },
	{
		command = "shellcheck",
		-- extra_args = { "--severity", "warning" },
	},
})

-- additional plugins
lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{ "cocopon/iceberg.vim" },
	{ "shaunsingh/nord.nvim" },
	{ "ellisonleao/gruvbox.nvim" },

	{ "theprimeagen/harpoon" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "folke/trouble.nvim" },
	{ "junegunn/goyo.vim" },

	{ "vim-pandoc/vim-pandoc-syntax" },
	{
		"lervag/vimtex",
		config = function()
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.tex_conceal = "abdmg"
			vim.cmd("hi Conceal guibg=none ctermbg=none")
		end,
		ft = "tex",
	},
	{ "vlime/vlime",
    rtp = "vim/"
  },
  { "github/copilot.vim" }
}
