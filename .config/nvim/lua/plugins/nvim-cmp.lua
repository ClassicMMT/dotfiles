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
    "R-nvim/cmp-r", -- for r autocompletion
  },

  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"
    local types = require "cmp.types"

    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.setup {}

    -- for de-priorotising snippets, text and keywords
    local function deprioritise(kind)
      return function(e1, e2)
        if e1:get_kind() == kind then
          return false
        end
        if e2:get_kind() == kind then
          return true
        end
      end
    end

    cmp.setup {
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },

      experimental = {
        ghost_text = true,
      },

      window = {
        documentation = cmp.config.window.bordered(),
      },

      -- view = {
      --   entries = "native",
      -- },

      sorting = {
        priority_weight = 10,
        -- see: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
        comparators = {
          -- puts snippets, text and keywords at the bottom
          deprioritise(types.lsp.CompletionItemKind.Snippet),
          deprioritise(types.lsp.CompletionItemKind.Text),
          deprioritise(types.lsp.CompletionItemKind.Keyword),
          cmp.config.compare.scopes,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,

          -- Copied from cmp-under-comparator - lowers priority of completions starting with _ or __
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find "^_+"
            local _, entry2_under = entry2.completion_item.label:find "^_+"
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          -- cmp.config.compare.kind,
          -- cmp.config.compare.sort_text,
          -- cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-l>"] = cmp.mapping(function(fallback) -- jump to next
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback) -- jump to previous
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        -- ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort() -- Close completion without leaving insert mode
          else
            fallback() -- If completion is not visible, fall back to the default behavior
          end
        end, { "i" }),
      },

      sources = cmp.config.sources {
        { name = "path" }, -- file system paths
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "cmp_r" }, -- for R
        -- { name = "jedi" },
      },

      formatting = {
        -- fields = { "menu", "abbr", "kind" },
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_char = "...",
          mode = "symbol",
        },
        expandable_indicator = true,
      },
    }

    -- Custom configuration for html
    cmp.setup.filetype("html", {
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        -- { name = "path" },
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
        },
      },
    })
  end,
}
