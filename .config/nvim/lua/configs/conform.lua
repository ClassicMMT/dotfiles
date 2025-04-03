local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettierd" },

    -- Custom
    markdown = { "prettier" },
    -- python = { "isort", "black" },
    -- python = { "isort" },
    json = { "prettier" },
    javascript = { "prettier" },
    -- install in R: install.packages("styler")
    r = { "styler" },
    rmd = { "styler" },
  },

  formatters = {
    prettierd = {
      args = { "--stdin-filepath", "$FILENAME", "--parser=html", "--print-width=120" },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    async = false,
    lsp_fallback = true,
  },
}

return options
