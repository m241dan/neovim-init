-- "Lazy" Plugin manager

-- Set the lazypath for use to see if it already exists with fs_stat (which is just fstat in bash)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- This will download (using git) the Lazy plugin manager
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Now that we have downloaded Lazy, when we do "setup", it will download the list of plugins
-- in the table that we pass into it.

require("lazy").setup({
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- Treesitter
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Darcula Theme
  {
    "xiantang/darcula-dark.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        vim.cmd.colorscheme("darcula-dark")
    end,
  },
      -- LSP Support
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim", -- to download clangd
      "williamboman/mason-lspconfig.nvim", -- to configure the tool that downloads clangd   
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} }, -- A progress bar for what the LSP is doing

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim', -- This adds support in our LSP for editing vim specific files (other LSP claims vim is not defined all the time)

      -- Auto complete support
      'hrsh7th/nvim-cmp',
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
})
