if vim.g.loaded_co_author then
    return
end

vim.g.loaded_co_author = true

vim.api.nvim_create_user_command('CoAuthor', function()
    require("co-author").list()
end, {})

vim.api.nvim_create_user_command('GitCoAuthors', function()
    require("co-author").list()
end, {})
