local M = {}

M.int_to_rgb = function(color)
    local r = math.floor(color / 2 ^ 16) % 256
    local g = math.floor(color / 2 ^ 8) % 256
    local b = color % 256
    return r, g, b
end


M.format_int_color = function (int_color)
    if int_color == nil then
        return "NIL"
    end

    local r, g, b = M.int_to_rgb(int_color)
    return string.format("RGB(%d,%d,%d)", r, g, b)
end


---@param key string
---@param color Color
M.inspect_color = function(key, color)
    local fg = M.format_int_color(color.fg)
    local bg = M.format_int_color(color.bg)
    local read = io.read()

    print(fg .. bg)
end


---@param colors table<string, Color>
local print_colors = function(colors)
    for key, color in pairs(colors) do
        print(key, vim.inspect(color))
    end
end

---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return number Packed integer
M.rgb_to_int = function(r, g, b)
    return r * 2 ^ 16 + g * 2 ^ 8 + b
end

local function inspect_theme()
    local groups = vim.api.nvim_get_hl(0, {})
    print(vim.inspect(groups))
end


M.contains_array = function(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

return M
