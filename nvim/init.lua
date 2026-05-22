-- ============================================================
--  Neovim 0.12.x Config — migrated to vim.pack + built-in LSP
--  Launch with: NVIM_APPNAME=nvim-next nvim
-- ============================================================

-- ─── Plugin helper ───────────────────────────────────────────
local gh = function(x) return 'https://github.com/' .. x end

-- ─── Options (identical to old config) ──────────────────────
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 5
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- ─── Keymaps (identical to old config) ──────────────────────
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>b', '<C-^>', { desc = '[B]ack to previous buffer' })
vim.keymap.set('n', '<leader>w', '<cmd>bdelete<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>rr', '<cmd>edit<CR>', { desc = '[R]eload current buffer' })
vim.keymap.set('n', '<leader>ra', '<cmd>bufdo edit<CR>', { desc = '[R]eload [A]ll buffers' })
vim.keymap.set('n', '<leader>rc', function() vim.cmd.edit(vim.fn.stdpath 'config' .. '/init.lua') end, { desc = 'Edit [R]C file (init.lua)' })
vim.keymap.set('n', '<leader>so', function() vim.cmd.source(vim.fn.stdpath 'config' .. '/init.lua') end, { desc = '[So]urce init.lua' })

-- Indentation
vim.keymap.set('n', '>', '>>', { desc = 'Indent right' })
vim.keymap.set('n', '<', '<<', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })

-- System clipboard
vim.keymap.set({ 'n', 'v' }, 'Y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'v' }, 'P', '"+p', { desc = 'Paste from system clipboard' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- ─── Diagnostic Config (identical to old config) ────────────
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
}
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = '[E]xpand diagnostic message' })

-- ─── Autocmds (identical to old config) ─────────────────────
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing whitespace on save',
  group = vim.api.nvim_create_augroup('trim-whitespace', { clear = true }),
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- ─── Plugins via vim.pack (replaces lazy.nvim) ─────────────
vim.pack.add {
  gh 'NMAC427/guess-indent.nvim',
  gh 'christoomey/vim-tmux-navigator',
  gh 'numToStr/Comment.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'folke/which-key.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope-fzf-native.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'mason-org/mason.nvim',
  gh 'j-hui/fidget.nvim',
  gh 'Everblush/nvim',
  gh 'mikusriekstins/inlinecoder.nvim',
  gh 'nvim-treesitter/nvim-treesitter',
}

-- ─── Plugin Configurations ──────────────────────────────────

-- Guess indent
require('guess-indent').setup {}

-- Comment.nvim
require('Comment').setup { mappings = { basic = false, extra = false } }
local cm_api = require('Comment.api')
vim.keymap.set('n', '<leader>c', function() cm_api.toggle.linewise.current() end,
  { desc = '[C]omment toggle current line' })
vim.keymap.set('v', '<leader>c', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, true, true), 'nx', false)
  cm_api.toggle.linewise(vim.fn.visualmode())
end, { desc = '[C]omment toggle selection' })

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Which-key
require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>f', desc = '[F]ind Files' },
    { '<leader>F', desc = '[F]ind Text in Files' },
    { '<leader>b', desc = '[B]ack to previous buffer' },
    { '<leader>w', desc = 'Close current buffer' },
    { '<leader>/', desc = 'Search by Grep' },
    { '<leader>.', desc = 'Recent Files' },
    { '<leader>e', desc = '[E]xpand diagnostic message' },
    { '<leader>q', desc = 'Open diagnostic [Q]uickfix list' },
    { '<leader>r', group = '[R]eload' },
    { '<leader>rr', desc = '[R]eload current buffer' },
    { '<leader>ra', desc = '[R]eload [A]ll buffers' },
    { '<leader>rc', desc = 'Edit [R]C file (init.lua)' },
    { '<leader>so', desc = '[So]urce init.lua' },
    { '<leader>g', desc = '[G]enerate code with InlineCoder', mode = 'v' },
    { '<leader>c', desc = '[C]omment toggle', mode = { 'n', 'v' } },
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { 'g', group = '[G]oto' },
    { 'gd', desc = '[G]oto [D]efinition' },
    { 'gr', desc = '[G]oto [R]eferences' },
    { 'gi', desc = '[G]oto [I]mplementation' },
    { 'gt', desc = '[G]oto [T]ype Definition' },
    { 'grn', desc = '[R]e[n]ame' },
    { 'ga', desc = '[G]oto Code [A]ction' },
    { 'grD', desc = '[G]oto [D]eclaration' },
    { '<leader>k', desc = 'Hover Documentation' },
  },
}

-- Colorscheme
vim.cmd.colorscheme('everblush')

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = { i = { ['<esc>'] = require('telescope.actions').close } },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[F]ind Files' })
vim.keymap.set('n', '<leader>F', builtin.live_grep, { desc = '[F]ind Text in Files' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10, previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- Mason + mason-tool-installer (still used for binary management)
require('mason').setup {}
require('mason-tool-installer').setup {
  ensure_installed = {
    'lua-language-server',
    'rust-analyzer',
    'stylua',
    'typescript-language-server',
  },
}

-- InlineCoder
require('inlinecoder').setup {
  api_url = 'http://bluefin.local:8080/v1/chat/completions',
}
vim.keymap.set('v', '<leader>g', ':InlineCoderGenerate<CR>', { desc = '[G]enerate code with InlineCoder' })

-- Treesitter (now only handles parser installation; highlight/indent are native in 0.12)
require('nvim-treesitter').setup {}

-- Install parsers on first run (equivalent to old ensure_installed)
local ts_parsers = {
  'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline',
  'query', 'rust', 'vim', 'vimdoc', 'typescript', 'tsx', 'javascript', 'json',
}
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  once = true,
  callback = function() require('nvim-treesitter').install(ts_parsers) end,
})

-- Enable treesitter highlight
group_ts = vim.api.nvim_create_augroup('treesitter_config', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group_ts,
  callback = function() vim.treesitter.start() end,
})

-- Enable treesitter indent
vim.api.nvim_create_autocmd('FileType', {
  group = group_ts,
  callback = function() vim.bo.indentexpr = [[v:lua.require'nvim-treesitter'.indentexpr()]] end,
})

-- ─── Built-in LSP (replaces nvim-lspconfig + blink.cmp) ─────

-- Enable native autocomplete globally
vim.opt.completeopt = 'menu,menuone,noselect,popup'
vim.o.autocomplete = true

-- LSP configuration convention: config files in lsp/<server-name>.lua
-- Returns a configuration table, loaded by vim.lsp.config
-- For now we inline the configs (can be split into lsp/*.lua files later)

vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript.jsx' },
})

-- Enable servers (will auto-start based on filetype)
vim.lsp.enable { 'rust_analyzer', 'ts_ls' }

-- Enable native LSP completion on LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_completion', { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then return end
    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client_id, args.buf, { autotrigger = true })
    end
  end,
})

-- LSP buffer keymaps (on attach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>k', vim.lsp.buf.hover, 'Hover Documentation')
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Goto definition / references / etc via Telescope (if LSP buffer, override global)
    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gi', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('gt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')

    -- Document highlights
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Inlay hints toggle
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- ─── Fidget (LSP progress indicator) ────────────────────────
require('fidget').setup {}
