-- lua/plugins/dotenv.lua
return {
  "ellisonleao/dotenv.nvim",
  lazy = false, -- 부팅 즉시 로드
  priority = 1000, -- 가장 먼저
  config = function()
    require("dotenv").setup({
      enable_on_load = true,
      verbose = false,
    })

    -- ① UI 플러그인이 읽을 변수 이름을 DATABASE_URL 로 지정
    vim.g.db_ui_env_variable_url = "DATABASE_URL"
    vim.g.db_ui_env_variable_name = "DATABASE_NAME" -- 없으면 이름을 URL 에서 추출

    -- (선택) UI가 요구하는 기본 이름(DBUI_URL)도 만들어 주고 싶다면
    vim.env.DBUI_URL = vim.env.DATABASE_URL
  end,
}
