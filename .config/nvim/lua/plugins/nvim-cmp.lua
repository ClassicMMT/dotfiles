return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path", -- source for file system paths

    -- command line autocompletion
    {
      "hrsh7th/cmp-cmdline",
      event = "CmdlineEnter",
      config = function()
        local cmp = require "cmp"
        local mapping = cmp.mapping

        cmp.setup.cmdline(":", {
          mapping = mapping.preset.cmdline {
            ["<CR>"] = mapping.confirm { select = true },
            ["<C-j>"] = mapping(mapping.select_next_item(), { "i", "c" }),
            ["<C-k>"] = mapping(mapping.select_prev_item(), { "i", "c" }),
            ["<C-e>"] = mapping.abort(), -- close completion window
          },
          sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
          matching = { disallow_symbol_nonprefix_matching = false },
        })
      end,
    },

    -- snippets
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vscode-like pictograms
  },

  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm { select = true },
      },

      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      },

      -- configure lspkind for vscode-like pictograms in completion menu
      formatting = {
        fiels = { "menu", "abbr", "kind" },
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_char = "...",
        },
        expandable_indicator = true,
      },
    }
  end,
}
