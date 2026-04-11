vim.pack.add {
    "https://github.com/catppuccin/nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/stevearc/conform.nvim"
}

require('vim._core.ui2').enable()

require('mini.sessions').setup({
    autoread = true,
})
require("mini.basics").setup({
    options = { basic = false },
    mappings = {
        windows = true,
        move_with_alt = true,
    },
})
require('mini.tabline').setup()
require("mini.icons").setup()
require("mini.pick").setup()
require("mini.move").setup()
require("mini.indentscope").setup()
require("mini.trailspace").setup()
require("mini.files").setup({ windows = { preview = true } })
require("mini.diff").setup()
require("mini.git").setup()
require("mini.hipatterns").setup()
require("mini.operators").setup()
require("mini.pairs").setup({ modes = { command = true } })
require("mini.surround").setup()
require("mini.bracketed").setup()
require("mini.trailspace").setup()
require("mini.git").setup()
require("mini.extra").setup()
require("mini.jump").setup()
require("mini.completion").setup()

local jump2d = require("mini.jump2d")
jump2d.setup({
    spotter = jump2d.gen_spotter.pattern("[^%s%p]+"),
    labels = "arstneioqwfpluy;zxcdh,./bjvk",
    view = { dim = true, n_steps_ahead = 2 },
})

require('conform').setup({
    default_format_opts = {
        lsp_format = 'fallback',
    },
    formatters_by_ft = { lua = { "stylua" }, odin = { "odinfmt" } },
    format_on_save = {
        timeout_ms = 500,
    },
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.mouse = "a"
vim.o.hlsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.autocomplete = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.wildoptions = "pum,fuzzy"

local nmap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local nmap_leader = function(suffix, rhs, desc)
    vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end

vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
    MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end)

nmap_leader("qq", "<Cmd>qa<CR>", "Quit all")

local new_scratch_buffer = function()
    vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end
nmap_leader("bd", ":bdelete<CR>", "Delete")
nmap_leader("bs", new_scratch_buffer, "Scratch")
nmap("H", ":bprevious<CR>", "Previous buffer")
nmap("L", ":bnext<CR>", "Next buffer")

nmap_leader("fr", "<Cmd>Pick resume<CR>", "Resume")
nmap_leader("fb", "<Cmd>Pick buffers<CR>", "Buffers")
nmap_leader("fg", "<Cmd>Pick grep_live<CR>", "Grep live")
nmap_leader("fG", "<Cmd>Pick grep pattern='<cword>'<CR>", "Grep current word")
nmap_leader("fl", "<Cmd>Pick buf_lines scope='all'<CR>", "Lines (all)")
nmap_leader("fL", "<Cmd>Pick buf_lines scope='current'<CR>", "Lines (buf)")
nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
nmap_leader("fs", "<Cmd>Pick lsp scope='workspace_symbol'<CR>", "Symbols workspace")
nmap_leader("fS", "<Cmd>Pick lsp scope='document_symbol'<CR>", "Symbols document")

nmap_leader("ed", "<Cmd>lua MiniFiles.open()<CR>", "Directory")
nmap_leader("ef", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", "File directory")
nmap_leader("en", "<Cmd>lua MiniNotify.show_history()<CR>", "Notifications")

nmap("gr", "<Cmd>Pick lsp scope='references'<CR>", "References (LSP)")
nmap("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", "Source definition")
nmap_leader("gd", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle diff")

nmap_leader("ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions")
nmap_leader("cd", "<Cmd>Pick diagnostic scope='all'<CR>", "Diagnostic workspace")
nmap_leader("cD", "<Cmd>Pick diagnostic scope='current'<CR>", "Diagnostic buffer")
nmap_leader("cf", "<Cmd>lua require('conform').format({lsp_fallback=true})<CR>", "Format")
nmap_leader("cr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")

nmap_leader("sd", '<Cmd>lua MiniSessions.select("delete")<CR>', "Delete")
nmap_leader("sn", '<Cmd>lua MiniSessions.write(vim.fn.input("Session name: "))<CR>', "New")
nmap_leader("sl", '<Cmd>lua MiniSessions.select("read")<CR>', "Load")

vim.cmd.colorscheme("catppuccin")

vim.lsp.enable({ "lua_ls", "clangd", "ols" })
