return {
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
