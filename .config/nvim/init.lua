--------------
--- PACKER ---
--------------

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end


-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'                                                    -- Package manager
  use 'tpope/vim-fugitive'                                                        -- Git commands in nvim
  use 'tpope/vim-rhubarb'                                                         -- Fugitive-companion to interact with github
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- Add git related info in the signs columns and popups
  use 'numToStr/Comment.nvim'                                                     -- "gc" to comment visual regions/lines
  use 'nvim-treesitter/nvim-treesitter'                                           -- Highlight, edit, and navigate code
  use 'nvim-treesitter/nvim-treesitter-textobjects'                               -- Additional textobjects for treesitter
  use 'neovim/nvim-lspconfig'                                                     -- Collection of configurations for built-in LSP client
  use 'williamboman/nvim-lsp-installer'                                           -- Automatically install language servers to stdpath
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }               -- Autocompletion
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }           -- Snippet Engine and Snippet Expansion
  use 'mjlbach/onedark.nvim'                                                      -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim'                                                 -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim'                                       -- Add indentation guides even on blank lines
  use 'tpope/vim-sleuth'                                                          -- Detect tabstop and shiftwidth automatically
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
  use { "nvim-telescope/telescope-file-browser.nvim" }                            -- File browser extension for telescope
  use { "catppuccin/nvim", as = "catppuccin" } -- Catppuccin theme for neovim
  use 'folke/tokyonight.nvim' -- Tokyo night theme for neovim
  
  use 'glepnir/dashboard-nvim' -- Dashboard for neovim
  use 'kyazdani42/nvim-tree.lua' -- File tree browser
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'} -- Bufferline to show buffers in a line
  use 'ethanholz/nvim-lastplace'
  use 'steelsojka/pears.nvim' -- Auto pairs ( -> ()
  use 'folke/which-key.nvim'
  
  -- language supports
  use 'ron-rs/ron.vim' -- .ron support
  
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
  
  if is_bootstrap then
    require('packer').sync()
  end
  
end)
-- stylua: ignore end

require 'plugin-configs'

-- Print a helpful message
if is_bootstrap then
  print '===================================='
  print '| Packer has been installed to     |'
  print '| your system, you can now run     |'
  print '| :PackerSync to install plugins   |'
  print '===================================='
  return
end

-- Automatically source and re-compile packer whenever you save this neovim config
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

---------------
--- MODULES ---
---------------

if not is_bootstrap then
  require 'settings'
  require 'mappings'
end
