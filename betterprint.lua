local m = {}
m.settings = {

    --- string
    mode = 'simple'
}

local function echo(input) os.execute('echo ' .. input) end
local function tableparser(list)
    local parse, pos = {}, 0
    for k, v in pairs(list) do
        pos = pos + 1
        parse[pos] = k .. ' = ' .. v
    end
    return '{' .. table.concat(parse, ', ') .. '}'
end

---@param ... any
function print(...)
    for _, v in ipairs({ ... }) do
        local info = debug.getinfo(2, "Sl")
        local prefix = ''
        if m.settings.mode == 'simple' then
            prefix = info.short_src .. ':' .. info.currentline .. ': '
        elseif m.settings.mode == 'prettier' then
            prefix = '[' .. info.short_src .. ' : ' .. info.currentline .. ']: '
        end

        echo(prefix .. (type(v) == 'table' and tableparser(v) or tostring(v)))
    end
end

return m
