if vim.g.loaded_co_author then
    return
end

vim.g.loaded_co_author = true

vim.cmd('command! CoAuthor lua require("co-author").list()')
vim.cmd('command! GitCoAuthors lua require("co-author").list()')

