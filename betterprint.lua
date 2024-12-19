local m = {}
m.settings = {

    --- string
    mode = 'simple'
}
m.printModes = {
    ["classic"] = function(info)
        return ''
    end,
    ["simple"] = function(info)
        return info.short_src .. ':' .. info.currentline .. ': '
    end,
    ["prettier"] = function(info)
        return '[' .. info.short_src .. ' : ' .. info.currentline .. ']: '
    end
}

m.parsers = {
    ["table"] = function(t)
        local ct = {}
        for k, v in pairs(t) do
            table.insert(ct, k .. ' = ' .. v)
        end
        return '{' .. table.concat(ct, ', ') .. '}'
    end,
    ["function"] = function(f)
        return debug.getinfo(f, "n").name
    end
}

local function echo(input) os.execute('echo ' .. input) end

---@param ... any
function print(...)
    for _, v in ipairs({ ... }) do
        local prefix = m.printModes[m.settings.mode](debug.getinfo(2, "Sl"))
        echo(prefix .. (m.parsers[type(v)] or tostring)(v))
    end
end

return m
