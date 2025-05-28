-- vim.lsp.set_log_level("debug")
if vim.g.vscode then
  -- VSCode extension
else
  require("config.lazy")

  vim.cmd([[
    set spelllang+=cjk
    set spell
  ]])

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.rs",
    callback = function()
      vim.cmd("silent !cargo fmt")
    end,
  })

  -- Lazy.nvim의 모든 플러그인이 로드된 후 `cargo build --release` 실행
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      local lazy_config = require("lazy.core.config")
      if lazy_config.options.dev then
        vim.cmd("!cargo build --release")
        print("Cargo build --release completed.")
      end
    end,
  })
end
