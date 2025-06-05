vim.g.sonokai_style = "shusia"
vim.g.sonokai_better_performance = 1

return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("sonokai")
    end,
  },
}
