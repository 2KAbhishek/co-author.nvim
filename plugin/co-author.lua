if vim.g.loaded_co_author then
    return
end

vim.g.loaded_co_author = true

vim.cmd('command! GitCoAuthors lua require("co-author").list()')

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>gA', ':GitCoAuthors', opts)
