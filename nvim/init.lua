-- Options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

-- Disable background color query to prevent OSC sequences in tmux
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 5
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
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
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>b', '<C-^>', { desc = '[B]ack to previous buffer' })
vim.keymap.set('n', '<leader>w', '<cmd>bdelete<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>rr', '<cmd>edit<CR>', { desc = '[R]eload current buffer' })
vim.keymap.set('n', '<leader>ra', '<cmd>bufdo edit<CR>', { desc = '[R]eload [A]ll buffers' })
vim.keymap.set('n', '<leader>rc', function() vim.cmd.edit(vim.fn.stdpath('config') .. '/init.lua') end, { desc = 'Edit [R]C file (init.lua)' })
vim.keymap.set('n', '<leader>so', function() vim.cmd.source(vim.fn.stdpath('config') .. '/init.lua') end, { desc = '[So]urce init.lua' })

-- Indentation keymaps - override default > and < to indent immediately
vim.keymap.set('n', '>', '>>', { desc = 'Indent right' })
vim.keymap.set('n', '<', '<<', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })

-- InlineCoder keymap
vim.keymap.set('v', '<leader>g', ':InlineCoderGenerate<CR>', { desc = '[G]enerate code with InlineCoder' })

-- Copy to system clipboard in visual mode
vim.keymap.set('v', 'Y', '"+y', { desc = 'Copy to system clipboard' })

-- Diagnostic Config & Keymaps
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true,   -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual linetypescript_language_servers
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = '[E]xpand diagnostic message' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

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

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
  { 'NMAC427/guess-indent.nvim', opts = {} },

  { -- Seamless navigation between tmux panes and vim splits
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  { -- Smart commenting plugin
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        -- Disable default keymaps since we want custom ones
        mappings = {
          basic = false,
          extra = false,
        },
      })

      local api = require('Comment.api')
      -- Add custom keymaps for <leader>c using the API
      vim.keymap.set('n', '<leader>c', function()
        api.toggle.linewise.current()
      end, { desc = '[C]omment toggle current line' })

      vim.keymap.set('v', '<leader>c', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = '[C]omment toggle selection' })
    end,
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },

      spec = {
        -- File and buffer operations
        { '<leader>f', desc = '[F]ind Files' },
        { '<leader>F', desc = '[F]ind Text in Files' },
        { '<leader>b', desc = '[B]ack to previous buffer' },
        { '<leader>w', desc = 'Close current buffer' },
        { '<leader>/', desc = 'Search by Grep' },
        { '<leader>.', desc = 'Recent Files' },
        { '<leader>e', desc = '[E]xpand diagnostic message' },
        { '<leader>q', desc = 'Open diagnostic [Q]uickfix list' },

        -- Reload operations
        { '<leader>r', group = '[R]eload' },
        { '<leader>rr', desc = '[R]eload current buffer' },
        { '<leader>ra', desc = '[R]eload [A]ll buffers' },
        { '<leader>rc', desc = 'Edit [R]C file (init.lua)' },
        { '<leader>so', desc = '[So]urce init.lua' },

        -- AI Code Generation
        { '<leader>g', desc = '[G]enerate code with InlineCoder', mode = 'v' },

        -- Commenting
        { '<leader>c', desc = '[C]omment toggle', mode = { 'n', 'v' } },

        -- Groups
        { '<leader>s', group = '[S]earch',   mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },

        -- LSP keymaps (shown when LSP is attached)
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
    },
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close,
            },
          },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      -- Primary keymaps
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[F]ind Files' })
      vim.keymap.set('n', '<leader>F', builtin.live_grep, { desc = '[F]ind Text in Files' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

      -- Additional search keymaps
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
          vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
          vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols,
            { buffer = buf, desc = 'Open Workspace Symbols' })
        end,
      })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set(
        'n',
        '<leader>/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch [/] in Open Files' }
      )

      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
        { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim',    opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
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

          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th',
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
              '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Get capabilities from blink.cmp if available, otherwise use defaults
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, 'blink.cmp')
      if has_blink then
        capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities())
      end

      local servers = {
        ts_ls = {
          cmd = { 'typescript-language-server', '--stdio' },
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript.jsx' },
          root_dir = function(fname)
            return vim.fs.root(fname, { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' })
          end,
        },
      }

      local ensure_installed = {
        'lua-language-server',
        'stylua',
        'typescript-language-server',
      }

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Setup LSP servers with explicit FileType autocmd
      for name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

        vim.api.nvim_create_autocmd('FileType', {
          pattern = server.filetypes,
          callback = function(args)
            vim.lsp.start({
              name = name,
              cmd = server.cmd,
              root_dir = server.root_dir and server.root_dir(args.file) or vim.fn.getcwd(),
              capabilities = server.capabilities,
            })
          end,
        })
      end

      -- vim.lsp.config('lua_ls', {
      --   on_init = function(client)
      --     if client.workspace_folders then
      --       local path = client.workspace_folders[1].name
      --       if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      --     end

      --     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      --       runtime = {
      --         version = 'LuaJIT',
      --         path = { 'lua/?.lua', 'lua/?/init.lua' },
      --       },
      --       workspace = {
      --         checkThirdParty = false,
      --         -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
      --         --  See https://github.com/neovim/nvim-lspconfig/issues/3189
      --         library = vim.api.nvim_get_runtime_file('', true),
      --       },
      --     })
      --   end,
      --   settings = {
      --     Lua = {},
      --   },
      -- })
      -- vim.lsp.enable 'lua_ls'
    end,
  },

  -- { -- Autoformat
  --   'stevearc/conform.nvim',
  --   event = { 'BufWritePre' },
  --   cmd = { 'ConformInfo' },
  --   keys = {
  --     {
  --       '<leader>f',
  --       function() require('conform').format { async = true, lsp_format = 'fallback' } end,
  --       mode = '',
  --       desc = '[F]ormat buffer',
  --     },
  --   },
  --   opts = {
  --     notify_on_error = false,
  --     format_on_save = function(bufnr)
  --       local disable_filetypes = { c = true, cpp = true }
  --       if disable_filetypes[vim.bo[bufnr].filetype] then
  --         return nil
  --       else
  --         return {
  --           timeout_ms = 501,
  --           lsp_format = 'fallback',
  --         }
  --       end
  --     end,
  --     formatters_by_ft = {
  --       lua = { 'stylua' },
  --     },
  --   },
  -- },

  -- { -- Autocompletion
  --   'saghen/blink.cmp',
  --   event = 'VimEnter',
  --   version = '1.*',
  --   dependencies = {
  --     {
  --       'L3MON4D3/LuaSnip',
  --       version = '2.*',
  --       build = (function()
  --         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
  --         return 'make install_jsregexp'
  --       end)(),
  --       dependencies = {
  --         -- `friendly-snippets` contains a variety of premade snippets.
  --         --    See the README about individual language/framework/plugin snippets:
  --         --    https://github.com/rafamadriz/friendly-snippets
  --         -- {
  --         --   'rafamadriz/friendly-snippets',
  --         --   config = function()
  --         --     require('luasnip.loaders.from_vscode').lazy_load()
  --         --   end,
  --         -- },
  --       },
  --       opts = {},
  --     },
  --   },
  --   --- @module 'blink.cmp'
  --   --- @type blink.cmp.Config
  --   opts = {
  --     keymap = {
  --       preset = 'default',
  --     },

  --     appearance = {
  --       nerd_font_variant = 'mono',
  --     },

  --     completion = {
  --       documentation = { auto_show = false, auto_show_delay_ms = 500 },
  --     },

  --     sources = {
  --       default = { 'lsp', 'path', 'snippets' },
  --     },

  --     snippets = { preset = 'luasnip' },

  --     fuzzy = { implementation = 'lua' },

  --     signature = { enabled = true },
  --   },
  -- },

  {
    'Everblush/nvim',
    name = 'everblush',
    priority = 1000,
    lazy = false,
  },

  {
    'mikusriekstins/inlinecoder.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require('inlinecoder').setup({
        api_url = "http://bluefin.local:8080/v1/chat/completions",
      })
    end,
  },

  -- Highlight todo, notes, etc in comments
  -- { 'folke/todo-comments.nvim',  event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- { -- Collection of various small independent plugins/modules
  --   'nvim-mini/mini.nvim',
  --   config = function()
  --     -- Better Around/Inside textobjects
  --     --
  --     -- Examples:
  --     --  - va)  - [V]isually select [A]round [)]paren
  --     --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
  --     --  - ci'  - [C]hange [I]nside [']quote
  --     require('mini.ai').setup { n_lines = 500 }

  --     -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --     --
  --     -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  --     -- - sd'   - [S]urround [D]elete [']quotes
  --     -- - sr)'  - [S]urround [R]eplace [)] [']
  --     require('mini.surround').setup()

  --     -- Simple and easy statusline.
  --     --  You could remove this setup call if you don't like it,
  --     --  and try some other statusline plugin
  --     local statusline = require 'mini.statusline'
  --     -- set use_icons to true if you have a Nerd Font
  --     statusline.setup { use_icons = vim.g.have_nerd_font }

  --     -- You can configure sections in the statusline by overriding their
  --     -- default behavior. For example, here we set the section for
  --     -- cursor location to LINE:COLUMN
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     statusline.section_location = function() return '%2l:%-2v' end

  --     -- ... and there is more!
  --     --  Check out: https://github.com/nvim-mini/mini.nvim
  --   end,
  -- },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local filetypes = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim',
        'vimdoc', 'typescript', 'tsx', 'javascript', 'json' }
      require('nvim-treesitter').install(filetypes)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function() vim.treesitter.start() end,
      })
    end,
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Set colorscheme after plugins are loaded
vim.schedule(function()
  vim.cmd.colorscheme('everblush')
end)

