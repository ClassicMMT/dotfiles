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

        -- for commands
        cmp.setup.cmdline(":", {
          mapping = mapping.preset.cmdline {
            ["<CR>"] = mapping.confirm { select = true },
            ["<C-j>"] = mapping(mapping.select_next_item(), { "i", "c" }),
            ["<C-k>"] = mapping(mapping.select_prev_item(), { "i", "c" }),
            ["<ESC>"] = mapping.abort(), -- close completion window
          },
          sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
          matching = { disallow_symbol_nonprefix_matching = false },
        })

        -- for searching
        cmp.setup.cmdline("/", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })
      end,
    },

    -- snippets
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
      },
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vscode-like pictograms
    "R-nvim/cmp-r", -- for r autocompletion
  },

  config = function()
    local cmp = require "cmp"
    local config = require "cmp.config"
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

    -- taken from Wincent's dotfiles (https://github.com/wincent/wincent/blob/64947cd9efc70844/aspects/nvim/files/.config/nvim/after/plugin/nvim-cmp.lua)
    -- logic to decide whether to insert or replace the suffix when inside a word
    local confirm = function(entry)
      local behavior = cmp.ConfirmBehavior.Replace
      if entry then
        local completion_item = entry.completion_item
        local newText = ""
        -- probably came from lsp server if .textEdit exists
        if completion_item.textEdit then
          newText = completion_item.textEdit.newText
        elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
          newText = completion_item.insertText
        else
          newText = completion_item.word or completion_item.label or ""
        end

        -- How many characters will be different after the cursor position if we
        -- replace?
        local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col

        -- Does the text that will be replaced after the cursor match the suffix
        -- of the `newText` to be inserted? If not, we should `Insert` instead.
        if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
          behavior = cmp.ConfirmBehavior.Insert
        end
      end
      cmp.confirm { select = true, behavior = behavior }
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
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, -- next suggestion
        -- Allows jumping from one snippet node to another
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
        -- ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            confirm(cmp.get_entries()[1])
          else
            fallback()
          end
        end),
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

    -- Custom configurations
    cmp.setup.filetype({ "html", "javascriptreact", "jsx" }, {
      sources = cmp.config.sources {
        {
          name = "nvim_lsp",
          -- filters out text sources
          entry_filter = function(entry, ctx)
            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
          end,
        },
        { name = "luasnip" },
        { name = "buffer" },
        -- { name = "path" },
      },
      sorting = {
        comparators = {
          deprioritise(types.lsp.CompletionItemKind.Text),
          deprioritise(types.lsp.CompletionItemKind.Keyword),
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
        },
      },
    })

    -- taken from Wincent's dotfiles (https://github.com/wincent/wincent/blob/64947cd9efc70844/aspects/nvim/files/.config/nvim/after/plugin/nvim-cmp.lua)
    -- fixes ghost text issues when inside a word
    local toggle_ghost_text = function()
      if vim.api.nvim_get_mode().mode ~= "i" then
        return
      end

      local cursor_column = vim.fn.col "."
      local current_line_contents = vim.fn.getline "."
      local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

      local should_enable_ghost_text = character_after_cursor == ""
        or vim.fn.match(character_after_cursor, [[\k]]) == -1

      local current = config.get().experimental.ghost_text
      if current ~= should_enable_ghost_text then
        config.set_global {
          experimental = {
            ghost_text = should_enable_ghost_text,
          },
        }
      end
    end

    vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
      callback = toggle_ghost_text,
    })
  end,
}
