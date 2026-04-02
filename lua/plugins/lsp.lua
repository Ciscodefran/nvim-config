local keyMapper = require("utils.keyMapper").mapKey

return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "basedpyright",
          "vtsls",
          "ruby_lsp",
          -- "rust_analyzer",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
      lspconfig.basedpyright.setup({})
      lspconfig.ruby_lsp.setup({
        root_dir = function(fname)
          return lspconfig.util.root_pattern("Gemfile", ".git")(fname)
            or vim.fn.fnamemodify(fname, ":p:h")
        end,
        single_file_support = true,
      })
      require("lspconfig").clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--clang-tidy-checks=*",
          "--fallback-style=Google",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig").util.root_pattern("compile_commands.json", ".git"),
        on_attach = function(client, bufnr)
          -- ① 문서 포맷팅 기능 활성화
          client.server_capabilities.documentFormattingProvider = true

          -- ② 저장 시 자동 포맷팅
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
          })
        end,
      })

      keyMapper("K", vim.lsp.buf.hover)
      keyMapper("gd", vim.lsp.buf.definition)
      keyMapper("<leader>ca", vim.lsp.buf.code_action)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}
