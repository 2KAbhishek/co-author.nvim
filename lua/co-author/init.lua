local co_author = {}

co_author.generate = function()
    local co_authors = vim.fn.systemlist('git -c log.showSignature=false log --format="%aN <%aE>"')
    local unique_co_authors = {}
    local seen = {}
    for _, author in ipairs(co_authors) do
        if not seen[author] then
            seen[author] = true
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
        vim.ui.select(items, { prompt = 'Select Co-Author' }, function(item, _)
            if item ~= nil then
                local co_authot_string = 'Co-authored-by: ' .. item
                vim.api.nvim_put({ co_authot_string }, 'c', true, true)
            end
        end)
    end
end

return co_author
