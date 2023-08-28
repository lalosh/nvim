local fn = vim.fn

-- Automatically install packer
-- data directory = ~/.locale/share/nvim
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("packer not installed")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- packer
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- utils used by others plugins
  use "nvim-lua/popup.nvim"   -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- color scheme
  use "sainnhe/sonokai"


  -- cmp plugins
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"     -- wire lsp results into cmp menu
  use "hrsh7th/cmp-nvim-lua"     -- get vim api from lua file via `vim.`

  -- cmp source
  use 'L3MON4D3/LuaSnip'
  use "rafamadriz/friendly-snippets"

  use "David-Kunz/cmp-npm"
  use "tamago324/cmp-zsh"
  use "Shougo/deol.nvim"

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- to hook a system-binary formatter into neovim
  use 'mhartington/formatter.nvim'

  -- add inlay hints support for the LSP that support it
  use "lvimuser/lsp-inlayhints.nvim"


  -- files finder
  --use "nvim-telescope/telescope.nvim"
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2', -- TODO: update later: it looks like the newest version have some bug currenlty
  }
  use 'nvim-telescope/telescope-media-files.nvim'


  -- add tree-sitter colors (coloring each identifier properly)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- file explorer
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-tree/nvim-tree.lua'

  -- add text object for xml attributes
  use 'kana/vim-textobj-user'
  use 'whatyouhide/vim-textobj-xmlattr'

  use "lewis6991/gitsigns.nvim"
  use 'junegunn/vim-peekaboo'

  use {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  }

  use 'tree-sitter/tree-sitter-embedded-template'

  use 'mfussenegger/nvim-lint'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
