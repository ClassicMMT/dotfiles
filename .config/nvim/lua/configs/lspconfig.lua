-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  -- "pyright",
  "basedpyright",
  "ts_ls",
  "clangd",
  "texlab",
  -- "ruff",
  -- "tinymist", -- for typst
  -- "jedi_language_server",
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

lspconfig.emmet_ls.setup {
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
}

lspconfig.tinymist.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "typ" },
  settings = {
    formatterMode = "typstyle",
  },
}

lspconfig.ts_ls.setup {
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
}

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

-- this line is only needed for pyright - to deactivate import warnings
-- nvlsp.capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
lspconfig.basedpyright.setup {
  filetypes = { "py" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    basedpyright = { -- change this line to python if going back to pyright
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        diagnosticMode = "openFilesOnly", -- Options: openFilesOnly, workspace
        typeCheckingMode = "off", -- Options: off, basic, strict
        -- IMPORTANT INFO FOR STUBS:
        -- stubs should be installed globally (NOT in a virtual environment) so they can be used across environments
        -- install from: https://github.com/microsoft/python-type-stubs
        -- find directory with: pip show microsoft-python-type-stubs
        stubPath = "/opt/miniconda3/lib/python3.12/site-packages",
        logLevel = "Information", -- Options: Error, Warning, Information, Trace
        diagnosticSeverityOverrides = {
          strictListInference = true,
          strictDictionaryInference = true,
          strictSetInference = true,
          reportUnusedExpression = "none",
          reportUnusedCoroutine = "none",
          reportUnusedClass = "none",
          reportUnusedImport = "none",
          reportUnusedFunction = "none",
          reportUnusedVariable = "none",
          reportUnusedCallResult = "none",
          reportDuplicateImport = "warning",
          reportPrivateUsage = "none",
          reportConstantRedefinition = "none",
          -- reportIncompatibleMethodOverride = "error",
          -- reportMissingImports = "error",
          -- reportUndefinedVariable = "error",
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
}

lspconfig.texlab.setup {
  filetypes = { "tex", "plaintex", "rmarkdown", "rmd" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
