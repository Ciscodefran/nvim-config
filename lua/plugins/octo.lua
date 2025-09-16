return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("octo").setup({
        -- use_local_fs = true,
        enable_builtin = false,
        default_remote = { "origin" },
        picker = "telescope",
        comment_icon = "▎",
        reaction_viewer_hint_icon = " ",
        mappings_disable_default = false,
        ssh_aliases = { ["github.work"] = "github.com" },
      })

      -- NOTE: Octo 버퍼에서만 localleader를 ','(comma)로 교체
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "octo", "octo_issue", "octo_pr", "octo_review", "octo_review_diff" },
        callback = function()
          vim.b.maplocalleader = ","
        end,
      })
    end,

    cmd = "Octo", -- lazy-load
  },
}
