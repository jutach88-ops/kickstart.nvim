-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- bootstrap lazy.nvim (si ce n'est pas déjà fait)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Lazy gère lui-même
  "folke/lazy.nvim",

  -- Dépendances utiles
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",

  -- Neotest principal
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neotest").setup({})
    end,
  },

  -- Adapter pour .NET
  {
    "nvim-neotest/neotest-dotnet",
    dependencies = { "nvim-neotest/neotest" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet")({
            -- configuration optionnelle
            -- args = { "--filter", "Category=Unit" },
          }),
        },
      })
    end,
  },
})



return {}
