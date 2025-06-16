return {
  -- 원본 extras-git 플러그인 비활성화
  { "lazyvim.plugins.extras.lang.git", enabled = false },

  -- 필요한 부분만 다시 선언
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "petertriho/cmp-git" },
    config = function()
      local cmp = require("cmp")

      -- nil 방어 로직
      local base_sources = cmp.get_config().sources or {}

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources(
          { { name = "cmp_git" } },
          base_sources -- 항상 table
        ),
      })
    end,
  },
}
