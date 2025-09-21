local function int_to_rgb(color)
    local r = math.floor(color / 2 ^ 16) % 256
    local g = math.floor(color / 2 ^ 8) % 256
    local b = color % 256
    return r, g, b
end

local function format_int_color(int_color)
    if int_color == nil then
        return "NIL"
    end

    local r, g, b = int_to_rgb(int_color)
    return string.format("RGB(%d,%d,%d)", r, g, b)
end

---@param key string
---@param color Color
local function inspect_color(key, color)
    local fg = format_int_color(color.fg)
    local bg = format_int_color(color.bg)
    local read = io.read()

    print(fg .. bg)
end

---@class Color
---@field bg number
---@field fg number
---@return Color
local function Color(bg, fg)
    return {
        bg = bg,
        fg = fg
    }
end

---@return table<string, Color>
local function get_colors()
    local colors = {}
    local highlights = vim.api.nvim_get_hl(0, {})
    for name, hl in pairs(highlights) do
        colors[name] = Color(hl.bg, hl.fg)
    end
    return colors
end

---@param colors table<string, Color>
local function print_colors(colors)
    for key, color in pairs(colors) do
        print(key, vim.inspect(color))
    end
end


---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return number Packed integer
local function rgb_to_int(r, g, b)
    return r * 2 ^ 16 + g * 2 ^ 8 + b
end


---@param number number
local function decrease(number)
    if number == nil then
        return nil
    end

    local r, g, b = int_to_rgb(number)
    r = math.max(r - 10, 0)
    g = math.max(g - 10, 0)
    b = math.max(b - 10, 0)

    return rgb_to_int(r, g, b)
end

---@param number number
local function increase(number)
    if number == nil then
        return nil
    end

    local r, g, b = int_to_rgb(number)
    r = math.min(r + 10, 255)
    g = math.min(g + 10, 255)
    b = math.min(b + 10, 255)

    return rgb_to_int(r, g, b)
end


---@param color Color
local function dim_color(color)
    local new_color = {}
    for key, intcolor in pairs(color) do
        new_color[key] = decrease(intcolor)
    end
    return new_color
end

---@param color Color
local function bright_color(color)
    local new_color = {}
    for key, intcolor in pairs(color) do
        new_color[key] = increase(intcolor)
    end
    return new_color
end

---@param colors table<string, Color>
local function dim_colors(colors)
    local new_colors = {}
    for key, color in pairs(colors) do
        local dimmed_color = dim_color(color)
        new_colors[key] = dimmed_color
    end

    return new_colors
end


---@param colors table<string, Color>
local function bright_colors(colors)
    local new_colors = {}
    for key, color in pairs(colors) do
        local changed_color = bright_color(color)
        new_colors[key] = changed_color
    end

    return new_colors
end

local function update_hl(key, color)
  local current = vim.api.nvim_get_hl(0, { name = key })

  for k, v in pairs(color) do
    if current[k] ~= nil then
      current[k] = v
    end
  end

  vim.api.nvim_set_hl(0, key, current)
end

---@param colors table<string, Color>
local function update_theme(colors)
    for key, color in pairs(colors) do
        update_hl(key, color)
    end
end


local function dim_theme()
    local colors = get_colors()
    local dimmed_colors = dim_colors(colors)
    update_theme(dimmed_colors)
end


local function bright_theme()
    local colors = get_colors()
    local brighter_colors = bright_colors(colors)
    update_theme(brighter_colors)
end

local function test_convert_colors()
    local int_color = 0
    local r, g, b = int_to_rgb(int_color)

    assert(r == 0, "Red must be 0")
    assert(g == 0, "Green must be 0")
    assert(b == 0, "Blue must be 0")

    r = 52
    g = 235
    b = 225

    int_color = rgb_to_int(r, g, b)
    print(int_color)
    assert(int_color == 3459713)
end

local function test_dim_color()
    local int_value = rgb_to_int(255, 255, 255)
    local color = Color(int_value, int_value)
    local dimmed_color = dim_color(color)
    local r, g, b = int_to_rgb(dimmed_color.fg)

    assert(r == 254, "Red must be 254")
    assert(g == 254, "Green must be 254")
    assert(b == 254, "Blue must ber 254")
end

local function inspect_theme()
    local groups = vim.api.nvim_get_hl(0, {})
    print(vim.inspect(groups))
end


-- test_convert_colors()
-- test_dim_color()
-- dim_theme()
bright_theme()
-- inspect_theme()
