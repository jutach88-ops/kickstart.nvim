-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- bootstrap lazy.nvim (si ce n'est pas déjà fait)




return {
  -- Dépendances de base
  "nvim-lua/plenary.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  
  -- Neotest avec adapter .NET
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",  -- Améliore les performances
      "nvim-neotest/nvim-nio",            -- Dépendance requise
      "Issafalcon/neotest-dotnet",        -- Adapter .NET
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet")({
            dap = { justMyCode = false },
          }),
        },
      })
    end,
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show output" },
    },
  },
   {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = true,
  },

  -- Configuration dans nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          -- Commande pour lancer OmniSharp
          cmd = { "omnisharp" },
          
          -- Options OmniSharp
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          
          -- Utiliser omnisharp-extended pour "go to definition"
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          
          -- Paramètres supplémentaires
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
              OrganizeImports = true,
            },
            RoslynExtensionsOptions = {
              EnableAnalyzersSupport = true,
              EnableImportCompletion = true,
            },
          },
        },
      },
    },
  },

  -- Assurer l'installation via Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "omnisharp",
		"netcoredbg",
      },
    },
  },
  
}