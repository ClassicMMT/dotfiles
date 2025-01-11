return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "bash",
      "markdown",
      "json",
      "gitignore",
      "python",
      "r",
    },
  },

  indent = { enable = true },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
}
