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
          "solargraph",
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
      -- ruby_lsp: Gemfile 프로젝트에서만. 기본 root_markers에 .git이 있어 Rails 외 리포지토리에서도
      -- 붙을 수 있으므로 Gemfile만으로 제한.
      vim.lsp.config("ruby_lsp", { root_markers = { "Gemfile" } })
      -- solargraph: Gemfile 없는 단일 .rb 파일에서만. 기본 root_markers={Gemfile,.git}이 Rails에서도
      -- 매칭되어 ruby_lsp와 중복되므로 root_dir 콜백으로 명시 차단.
      vim.lsp.config("solargraph", {
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          if fname == "" then return end
          if vim.fs.root(fname, { "Gemfile" }) then return end
          on_dir(vim.fs.dirname(fname))
        end,
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
