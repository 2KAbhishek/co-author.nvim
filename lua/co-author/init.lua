local co_author = {}

co_author.generate = function()
    local output = vim.api.nvim_call_function('system', { 'git log --format="%aN <%aE>"' })
    local co_authors = vim.split(output, '\n')
    local unique_co_authors = {}
    for _, author in ipairs(co_authors) do
        if not unique_co_authors[author] then
            unique_co_authors[author] = true
            unique_co_authors[#unique_co_authors + 1] = author
        end
    end
    return unique_co_authors
end

co_author.list = function()
    local co_authors = co_author.generate()
    local items = {}
    for _, author in ipairs(co_authors) do
        items[#items + 1] = author
    end
    if #co_authors > 0 then
        vim.ui.select(items, { prompt = 'Select Co-Authors' },
            function(item, _)
                local string = "Co-authored-by: " .. item
                local cursor_position = vim.api.nvim_win_get_cursor(0)
                local line = cursor_position[1]
                local column = cursor_position[2]

                vim.api.nvim_buf_set_lines(0, line, line, true, { string })
                vim.api.nvim_win_set_cursor(0, { line, column + #string })
            end)
    end
end

return co_author
