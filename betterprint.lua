local m = {}


m.default_config = {
    --string
    mode = 'simple'
}
m.config = m.default_config

m.printModes = {
    ["simple"] = function(info)
        return info.short_src .. ':' .. info.currentline .. ': '
    end,
    ["prettier"] = function(info)
        return '[' .. info.short_src .. ' : ' .. info.currentline .. ']: '
    end
}

m.parsers = {
    ["table"] = function(t)
        local function get_table_size(v)
            local i = 0
            for _ in pairs(v) do i = i + 1 end
            return i
        end

        local str, pos = '{ ', 1
        for k, v in pairs(t) do
            str = str .. '[' .. k .. '] = ' .. v
            if pos ~= get_table_size(t) then
                str = str .. ', '
            end
            pos = pos + 1
        end
        return str .. ' }'
    end,
}

function m.write(input)
    io.write(input .. '\n')
end

function m.parse(v)
    local custom_parser = m.parsers[type(v)]
    if custom_parser then return custom_parser(v) end
    return tostring(v)
end

function m.get_prefix()
    local custom_prefix = m.printModes[m.config.mode]
    if custom_prefix then return custom_prefix(debug.getinfo(2, "Sl")) end
    return ''
end

---@param ... any
function m.print(...)
    for _, v in ipairs({ ... }) do
        m.write(m.get_prefix() .. m.parse(v))
    end
end

return m
