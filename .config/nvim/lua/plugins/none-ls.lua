return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  event = { "BufReadPre", "BufNewfile", "BufEnter" },
  ft = { "python" },
  config = function()
    require("mason-null-ls").setup {
      ensure_installed = {
        "ruff",
        "prettier",
        "shfmt",
      },
      automatic_installation = true,
    }

    local null_ls = require "null-ls"
    local sources = {
      -- sorts imports
      require("none-ls.formatting.ruff").with { extra_args = { "--extend-select", "I" } },
      -- formats the rest of the file
      require "none-ls.formatting.ruff_format",
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          "json",
          "yaml",
          "markdown",
        },
      },
      -- format shell scripts with 4-space indentations
      null_ls.builtins.formatting.shfmt.with { args = { "-i", "4" } },
      null_ls.builtins.formatting.black,
      null_ls.builtins.diagnostics.mypy.with {
        args = function(params)
          return {
            "--hide-error-codes",
            "--hide-error-context",
            "--no-color-output",
            "--show-absolute-path",
            "--show-column-numbers",
            "--show-error-codes",
            "--no-error-summary",
            "--no-pretty",
            params.temp_path,
          }
        end,
        extra_args = function()
          local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX" or "/usr"
          return { "--python-executable", virtual .. "/bin/python3" }
        end,
      },
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds {
            group = augroup,
            buffer = bufnr,
          }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false, bufnr = bufnr }
            end,
          })
        end
      end,
    }
  end,
}
