local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "peter.plugins" },
    { import = "peter.plugins.lsp"},
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     ft = { "markdown" },
    --     build = function() vim.fn["mkdp#util#install"]() end,
    -- }
    
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     ft = { "markdown" },
    --     build = function()
    --         -- Install the plugin
    --         vim.fn["mkdp#util#install"]()
    --
    --         -- Navigate to the plugin's app directory and install the dependencies
    --         vim.cmd("!cd " .. vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app && npm install")
    --     end,
    -- }

    
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            -- Navigate to the plugin's app directory and install dependencies
            local install_path = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"

            -- Ensure npm is available, then install dependencies
            vim.fn.system({'npm', 'install', '--prefix', install_path})

            -- Install tslib globally
            vim.fn.system({'npm', 'install', '-g', 'tslib'})
        end,
    }
},

{
    change_detection = {
        notify = false
    },

    checker = {
        enabled = true,
        notify = false,
    },
})
