local models = require("eyes-wide-bright.models")
local utils = require("eyes-wide-bright.utils")
local config = require("eyes-wide-bright.config")

local M = {}

local INCREASE = 10;
local factors = {
    warm = {
        r = 0.9,
        g = 0.6,
        b = 0.2
    },

    cold = {
        r = 0.6,
        g = 0.6,
        b = 0.9
    },

    normal = {
        r = 1,
        g = 1,
        b = 1
    }
}

---@return table<string, Color>
M.get_colors = function()
    local colors = {}
    local highlights = vim.api.nvim_get_hl(0, {})
    for name, hl in pairs(highlights) do
        colors[name] = models.Color(hl.bg, hl.fg)
    end
    return colors
end

M.get_factor = function()
    local current_config = config.get_current_config()
    local factor = factors[current_config.mode]

    return factor
end

M.get_factor_decrease = function(factor_color)
    if (factor_color == 1) then
        return INCREASE;
    end

    return (INCREASE - (INCREASE * factor_color))
end

M.get_factor_increase = function(factor_color)
    return INCREASE * factor_color
end

---@param number number
M.decrease = function(number)
    if number == nil then
        return nil
    end

    local factor = M.get_factor()
    local r, g, b = utils.int_to_rgb(number)

    local fr = M.get_factor_decrease(factor.r)
    local fg = M.get_factor_decrease(factor.g)
    local fb = M.get_factor_decrease(factor.b)

    r = math.max(r - fr, 0)
    g = math.max(g - fg, 0)
    b = math.max(b - fb, 0)

    return utils.rgb_to_int(r, g, b)
end

---@param number number
M.increase = function(number)
    if number == nil then
        return nil
    end

    local factor = M.get_factor() 
    local r, g, b = utils.int_to_rgb(number)

    local fr = M.get_factor_increase(factor.r)
    local fg = M.get_factor_increase(factor.g)
    local fb = M.get_factor_increase(factor.b)

    r = math.min(r + fr, 255)
    g = math.min(g + fg, 255)
    b = math.min(b + fb, 255)

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
