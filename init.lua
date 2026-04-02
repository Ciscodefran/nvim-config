-- vim.lsp.set_log_level("debug")
if vim.g.vscode then
  -- VSCode extension
else
  require("config.lazy")

  vim.cmd([[
    set spelllang+=cjk
    set spell
  ]])

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.http", "*.rest" },
    callback = function()
      vim.bo.filetype = "http"
    end,
  })
end

if vim.fn.executable('termux-clipboard-set') == 1 then
    vim.opt.clipboard = "unnamedplus"
    
    vim.g.clipboard = {
        name = 'termux',
        copy = {
            ['+'] = 'termux-clipboard-set',
            ['*'] = 'termux-clipboard-set',
        },
        paste = {
            ['+'] = 'termux-clipboard-get',
            ['*'] = 'termux-clipboard-get',
        },
        cache_enabled = 0,
    }
else
    vim.opt.clipboard = "unnamedplus"
end

