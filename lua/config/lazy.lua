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
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  -- ────────────────────────────────────────────────────────────────────
  -- 1) 플러그인 스펙: 반드시 여기 안에 모든 플러그인 정의를 넣어야 합니다.
  -- ────────────────────────────────────────────────────────────────────
  spec = {
    -- LazyVim 기본 컬렉션
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- TypeScript, JSON, ESLint 등 extras
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    -- 사용자 플러그인(plugins/*.lua)
    { import = "plugins" },

    -- ────────────────────────────────────────────────────────────────────
    -- 2) nvim-cmp: JSX/TSX 속성 context에서도 LSP 제안을 뜨게 하기
    -- ────────────────────────────────────────────────────────────────────
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<A-Space>"] = cmp.mapping.complete(), -- mac IME 회피: Option+Space
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }),
          completion = {
            -- InsertEnter, TextChanged 시 자동 팝업
            autocomplete = {
              cmp.TriggerEvent.InsertEnter,
              cmp.TriggerEvent.TextChanged,
            },
            keyword_pattern = [[\w+]], -- 일반 단어 패턴
            keyword_length = 1,
          },
        })

        -- TSX(typescriptreact)에서도 같은 동작 보장
        cmp.setup.filetype("typescriptreact", {
          completion = {
            autocomplete = {
              cmp.TriggerEvent.InsertEnter,
              cmp.TriggerEvent.TextChanged,
            },
          },
        })
      end,
    },
  },

  -- ────────────────────────────────────────────────────────────────────
  -- 3) 기타 LazyVim 옵션
  -- ────────────────────────────────────────────────────────────────────
  defaults = {
    lazy = false,
    version = false, -- 항상 최신 커밋
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  checker = {
    enabled = true, -- 플러그인 자동 업데이트 체크
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
