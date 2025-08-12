return {
  "windwp/nvim-ts-autotag",
  ft = { "javascript", "html", "markdown", "xml" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-ts-autotag").setup {
      opts = {
        enable_close = true, -- auto close tags
        enable_rename = true, -- auto rename pairs of tags
        enable_close_on_slash = false, -- auto close on trailing </
      },
      -- customise each filetype separately
      per_filetype = {
        ["html"] = {
          enable_close_on_slash = true,
        },
      },
    }
  end,
}
