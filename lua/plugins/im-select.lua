return {
  "keaising/im-select.nvim",
  event = { "VeryLazy" },
  config = function()
    require("im_select").setup({
      default_im_select = "com.apple.keylayout.ABC", -- Normal/Visual 모드 = 영어
      -- macOS는 기본적으로 default_command = "macism" 이라 따로 지정 필요 없음
    })
  end,
}
