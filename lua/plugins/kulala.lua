return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      -- 기본 cURL/GRPCurl/웹소캣/openssl 실행 경로
      curl_path = "curl",
      grpcurl_path = "grpcurl",
      websocat_path = "websocat",
      openssl_path = "openssl",

      -- 추가 cURL 옵션
      additional_curl_options = {},

      -- 변수 범위(buffer vs global)
      environment_scope = "b",
      default_env = "dev",
      vscode_rest_client_environmentvars = false,

      -- 요청 타임아웃(ms), nil 면 무제한
      request_timeout = nil,
      -- 에러 발생 시 연속 실행 중단 여부
      halt_on_error = true,

      -- 호스트별 인증서 설정
      certificates = {},

      -- 쿼리 파라미터 인코딩 방식
      urlencode = "always",

      -- 응답 콘텐츠별 포매터/파일타입/경로해석기
      contenttypes = {
        ["application/json"] = {
          ft = "json",
          formatter = vim.fn.executable("jq") == 1 and { "jq", "." },
        },
        ["application/xml"] = {
          ft = "xml",
          formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "-" },
          pathresolver = vim.fn.executable("xmllint") == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
        },
        ["text/html"] = {
          ft = "html",
          formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "--html", "-" },
          pathresolver = nil,
        },
      },

      ui = {
        display_mode = "float",
        win_opts = {
          relative = "editor",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.6),
          row = math.floor(vim.o.lines * 0.2),
          col = math.floor(vim.o.columns * 0.1),
          border = "rounded",
        },
      },
      -- 디버그 레벨 (0~4)
      debug = 0,

      global_keymaps = false,
      kulala_keymaps = true,
      kulala_keymaps_prefix = "",
    },
    config = function(_, opts)
      require("kulala").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "http", "rest" },
        callback = function(evt)
          local buf = evt.buf
          local set = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true })
          end
          set("<CR>", function()
            require("kulala").run()
          end)
          set("<leader>Rs", function()
            require("kulala").run()
          end)
          set("<leader>Ra", function()
            require("kulala").run_all()
          end)
          set("<leader>Rb", function()
            require("kulala").scratchpad()
          end)
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        kulala = {
          command = "kulala-fmt",
          args = { "format", "$FILENAME" },
          stdin = false,
        },
      })
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        http = { "kulala" },
        rest = { "kulala" },
      })
    end,
  },
}
