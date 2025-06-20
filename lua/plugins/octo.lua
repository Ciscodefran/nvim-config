return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- fzf-lua 또는 snacks.nvim 중 하나만 사용해도 됨
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        -- 기본 설정들
        use_local_fs = true, -- 로컬 브랜치로 체크아웃해 LSP 기능 그대로 사용
        enable_builtin = false,
        default_remote = { "origin" },
        picker = "telescope", -- fzf-lua 또는 snacks로도 변경 가능
        picker_config = {
          mappings = {
            open_in_browser = { lhs = "<C-b>", desc = "open in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url" },
            checkout_pr = { lhs = "<C-o>", desc = "checkout PR" },
            merge_pr = { lhs = "<C-r>", desc = "merge PR" },
          },
        },
        comment_icon = "▎",
        reaction_viewer_hint_icon = " ",
        -- default keymaps 비활성화하고 커스터마이징하고 싶다면:
        -- mappings_disable_default = true,
        ssh_aliases = { -- ① SSH 호스트 별칭 → 실제 API 호스트
          ["github.work"] = "github.com",
        },
      })

      -- Markdown 문법 강조 트리시터 등록
      vim.treesitter.language.register("markdown", "octo")

      -- 자동완성맵핑(`@`, `#`) 활성화
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "octo",
        callback = function()
          vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })
          vim.keymap.set("i", "#", "#<C-x><C-o>", { silent = true, buffer = true })
        end,
      })
    end,
    cmd = "Octo", -- 명령어로 lazy-load
  },
}
