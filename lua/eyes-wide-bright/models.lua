local M = {}

---@class Color
---@field bg number
---@field fg number
---@return Color
M.Color = function(bg, fg)
    return {
        bg = bg,
        fg = fg
    }
end

return M
