return {
  -- HTTP REST-Client Interface
  {
    "mistweaverco/kulala.nvim",
    config = function()
      require("kulala").setup()
    end,
  },
}
