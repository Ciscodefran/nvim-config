local keyMapper = require("utils.keyMapper").mapKey

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "rust_analyzer",
          "volar",
          "eslint",
          "ltex",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
      -- lspconfig.volar.setup({
      --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      --   init_options = {
      --     vue = {
      --       hybridMode = false,
      --     },
      --   },
      -- })
      lspconfig.html.setup({})

      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          -- ✨ formatting capability 강제 활성화
          client.server_capabilities.documentFormattingProvider = true

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
        root_dir = lspconfig.util.root_pattern(
          "eslint.config.js",
          "eslint.config.mjs",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.json",
          "package.json",
          ".git"
        ),
        settings = {
          workingDirectory = { mode = "location" },
        },
      })

      lspconfig.tsserver.setup({
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
      })

      lspconfig.ltex.setup({
        settings = {
          ltex = {
            language = "ko",
            dictionary = {
              ["ko"] = { "기본사전", "사용자 정의 단어" },
            },
          },
        },
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
