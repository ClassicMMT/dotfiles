local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    
    -- Custom
    markdown = { "prettier" },
    python = { "isort", "black" },
    json = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    async = false,
    lsp_fallback = true,
  },
}

return options
