-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

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
  -- map("n", "<leader>hs", vim.lsp.buf.signature_help, opts "Show signature help")
  -- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  -- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  -- map("n", "<leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, opts "List workspace folders")

  map("n", "<leader>gt", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- servers
local servers = {
  "lua_ls",
  "html",
  -- "cssls",
  -- "pyright",
  "ts_ls",
  "clangd",
  "texlab",
  -- "ruff",
  -- "tinymist", -- for typst
  -- "jedi_language_server",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })

  vim.lsp.enable(lsp)
end

vim.lsp.config("emmet_ls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = {
    "css",
    "eruby",
    "svg",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
})
vim.lsp.enable "emmet_ls"

vim.lsp.config("cssls", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    css = { validate = true },
    less = { validate = true },
    scss = { validate = true },
  },
})
vim.lsp.enable "cssls"

vim.lsp.config("tinymist", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "typ" },
  settings = {
    formatterMode = "typstyle",
  },
})
vim.lsp.enable "tinymist"

vim.lsp.config("ts_ls", {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = {
    javascript = {
      autoImportFileExcludePatterns = { "node_modules", "bower_components" },
    },
    typescript = {
      autoImportFileExcludePatterns = { "node_modules", "bower_components" },
    },
  },
})
vim.lsp.enable "ts_ls"

-- configuring r language server - might need to run "install.packages('languageserver')"
-- lspconfig.r_language_server.setup {
--   cmd = { "R", "--no-save", "--no-restore", "-e", "languageserver::run()" },
--   filetypes = { "r", "rmd" },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- lspconfig.ruff.setup {
--   cmd = { "R", "--no-save", "--no-restore", "-e", "languageserver::run()" },
--   filetypes = { "r", "rmd" },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

vim.lsp.config("basedpyright", {
  filetypes = { "python" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    basedpyright = { -- change this line to python if going back to pyright
      analysis = {
        autoSearchPaths = false,
        useLibraryCodeForTypes = false, -- SET TO FALSE FOR LARGE FILES. IMPACTS PERFORMANCE.
        autoImportCompletions = true,
        diagnosticMode = "openFilesOnly", -- Options: openFilesOnly, workspace
        typeCheckingMode = "off", -- Options: off, basic, strict
        -- IMPORTANT INFO FOR STUBS:
        -- stubs should be installed globally (NOT in a virtual environment) so they can be used across environments
        -- install from: https://github.com/microsoft/python-type-stubs
        -- find directory with: pip show microsoft-python-type-stubs
        stubPath = "/opt/miniconda3/lib/python3.12/site-packages",
        logLevel = "Error", -- Options: Error, Warning, Information, Trace
        diagnosticSeverityOverrides = {
          strictListInference = true,
          strictDictionaryInference = true,
          strictSetInference = true,
          reportUnusedExpression = "none",
          reportUnusedCoroutine = "none",
          reportUnusedClass = "none",
          reportUnusedImport = "warning",
          reportUnusedFunction = "none",
          reportUnusedVariable = "none",
          reportUnusedCallResult = "none",
          reportDuplicateImport = "warning",
          reportPrivateUsage = "none",
          reportConstantRedefinition = "none",
          -- reportIncompatibleMethodOverride = "error",
          -- reportMissingImports = "error",
          reportUndefinedVariable = "error",
          -- reportAssertAlwaysTrue = "error",
        },

        inlayHints = {
          variableTypes = false,
          functionReturnTypes = false,
          pytestParameters = true,
          callArgumentNames = true,
        },
      },
    },
  },
})

vim.lsp.enable "basedpyright"

vim.lsp.config("texlab", {
  filetypes = { "tex", "plaintex", "rmarkdown", "rmd" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    texlab = {
      build = { onSave = false }, -- disable auto-build for speed
      forwardSearch = { executable = nil }, -- disable forward search unless needed
    },
  },
})
vim.lsp.enable "texlab"
