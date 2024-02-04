if vim.g.loaded_co_author then
    return
end

vim.g.loaded_co_author = true

vim.api.nvim_create_user_command('CoAuthor', 'lua require("co-author").list()', {})
