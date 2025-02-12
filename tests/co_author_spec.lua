local co_author = require('co-author')

describe('co-author', function()
    it('has the right functions defined', function()
        assert.is_function(co_author.generate)
        assert.is_function(co_author.list)
    end)
end)
