local models = require("eyes-wide-bright.models")
local utils = require("eyes-wide-bright.utils")

local M = {}

---@return table<string, Color>
M.get_colors = function()
    local colors = {}
    local highlights = vim.api.nvim_get_hl(0, {})
    for name, hl in pairs(highlights) do
        colors[name] = models.Color(hl.bg, hl.fg)
    end
    return colors
end


---@param number number
M.decrease = function(number)
    if number == nil then
        return nil
    end

    local r, g, b = utils.int_to_rgb(number)
    r = math.max(r - 10, 0)
    g = math.max(g - 10, 0)
    b = math.max(b - 10, 0)

    return utils.rgb_to_int(r, g, b)
end

---@param number number
M.increase = function(number)
    if number == nil then
        return nil
    end

    local r, g, b = utils.int_to_rgb(number)
    r = math.min(r + 10, 255)
    g = math.min(g + 10, 255)
    b = math.min(b + 10, 255)

    return utils.rgb_to_int(r, g, b)
end


---@param color Color
M.dim_color = function(color)
    local new_color = {}
    for key, intcolor in pairs(color) do
        new_color[key] = M.decrease(intcolor)
    end
    return new_color
end

---@param color Color
M.bright_color = function(color)
    local new_color = {}
    for key, intcolor in pairs(color) do
        new_color[key] = M.increase(intcolor)
    end
    return new_color
end

---@param colors table<string, Color>
M.dim_colors = function(colors)
    local new_colors = {}
    for key, color in pairs(colors) do
        local dimmed_color = M.dim_color(color)
        new_colors[key] = dimmed_color
    end

    return new_colors
end

---@param colors table<string, Color>
M.bright_colors = function(colors)
    local new_colors = {}
    for key, color in pairs(colors) do
        local changed_color = M.bright_color(color)
        new_colors[key] = changed_color
    end

    return new_colors
end

M.update_hl = function(key, color)
    local current = vim.api.nvim_get_hl(0, { name = key })

    for k, v in pairs(color) do
        if current[k] ~= nil then
            current[k] = v
        end
    end

    vim.api.nvim_set_hl(0, key, current)
end

---@param colors table<string, Color>
M.update_theme = function(colors)
    for key, color in pairs(colors) do
        M.update_hl(key, color)
    end
end


M.dim_theme = function()
    local colors = M.get_colors()
    local dimmed_colors = M.dim_colors(colors)
    M.update_theme(dimmed_colors)
end


M.bright_theme = function()
    local colors = M.get_colors()
    local brighter_colors = M.bright_colors(colors)
    M.update_theme(brighter_colors)
end

M.restore_theme = function()
    local scheme = vim.g.colors_name
    if scheme then
        vim.cmd.colorscheme(scheme)
    end
end

return M
