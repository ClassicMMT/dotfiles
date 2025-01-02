return {
  "windwp/nvim-ts-autotag",
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
