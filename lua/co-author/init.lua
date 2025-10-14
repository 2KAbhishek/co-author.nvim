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
    if #co_authors == 0 then
        return
    end

    -- Check if snacks.nvim is available
    local ok, snacks = pcall(require, 'snacks')
    if ok and snacks.picker then
        -- Use snacks.nvim picker with multi-select support
        local items = {}
        for _, author in ipairs(co_authors) do
            items[#items + 1] = { text = author }
        end
        
        snacks.picker.pick({
            items = items,
            format = 'text',
            prompt = 'Select Co-Author(s) (use <Tab> to multi-select)',
            confirm = function(picker, item)
                local selected = picker:selected({ fallback = true })
                picker:close()
                
                if #selected > 0 then
                    local co_author_lines = {}
                    for _, selected_item in ipairs(selected) do
                        local co_author_string = 'Co-authored-by: ' .. selected_item.text
                        table.insert(co_author_lines, co_author_string)
                    end
                    vim.api.nvim_put(co_author_lines, 'c', true, true)
                end
            end
        })
    else
        -- Fallback to vim.ui.select for single selection
        local items = {}
        for _, author in ipairs(co_authors) do
            items[#items + 1] = author
        end
        
        vim.ui.select(items, { prompt = 'Select Co-Author' }, function(item, _)
            if item ~= nil then
                local co_authot_string = 'Co-authored-by: ' .. item
                vim.api.nvim_put({ co_authot_string }, 'c', true, true)
            end
        end)
    end
end

return co_author
