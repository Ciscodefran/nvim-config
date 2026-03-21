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
      lspconfig.pyright.setup({})
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

      vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
        config = config or {}
        config.focus_id = ctx.method
        if not (result and result.contents) then
          return
        end
        local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
          return
        end
        return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
      end
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
