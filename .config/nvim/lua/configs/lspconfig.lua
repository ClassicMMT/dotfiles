-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  -- "r_language_server",
  "pyright",
  "ts_ls",
  "clangd",
}

local nvlsp = require "nvchad.configs.lspconfig"
local map = vim.keymap.set

-- change LSP mappings
nvlsp.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>hs", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>gt", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring r language server
lspconfig.r_language_server.setup {
  cmd = { "R", "--no-save", "--no-restore", "-e", "languageserver::run()" },
  filetypes = { "r", "rmd" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- lspconfig.emmet_ls.setup {
--   filetypes = {
--     "css",
--     "eruby",
--     "html",
--     "javascript",
--     "javascriptreact",
--     "less",
--     "sass",
--     "scss",
--     "svelte",
--     "typescriptreact",
--     "vue",
--   },
--   init_options = {
--     html = {
--       options = {
--         ["bem.enabled"] = true,
--       },
--     },
--   },
-- }
