return {
  {
    "tpope/vim-dadbod",
    cmd = { "DBUI", "DBUIToggle" },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = "tpope/vim-dadbod",
    cmd = { "DBUI", "DBUIToggle", "DBUIRefresh" },
    config = function()
      -- Nerd Font 아이콘 사용 여부
      vim.g.db_ui_use_nerd_fonts = 1

      -- 바텀시트 위치: "bottom" (기본), "top", "left", "right"
      -- vim.g.db_ui_win_position = "bottom"

      -- 바텀시트 높이 (rows)
      vim.g.db_ui_win_height = 20

      -- 좌우 분할 시 창 너비 (cols)
      vim.g.db_ui_win_width = 80

      -- 쿼리 실행 결과를 split이 아니라 floating window로 보고 싶다면
      vim.g.db_ui_use_floating_window = 1

      -- (선택) 실행 시 즉시 결과 창으로 포커스 주기
      vim.g.db_ui_execute_on_save = 1
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod", "hrsh7th/nvim-cmp" },
    ft = { "sql", "mysql", "plsql" }, -- README 예시와 동일
    config = function()
      local cmp = require("cmp")
      cmp.setup.filetype("sql", {
        sources = cmp.config.sources({ { name = "vim-dadbod-completion" } }, { { name = "buffer" } }),
      })
    end,
  },
}
