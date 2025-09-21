local models = require("eyes-wide-bright.models")
local utils = require("eyes-wide-bright.utils")
local eyes = require("eyes-wide-bright.eyes")


local M = {}

M.test_convert_colors = function()
    local int_color = 0
    local r, g, b = utils.int_to_rgb(int_color)

    assert(r == 0, "Red must be 0")
    assert(g == 0, "Green must be 0")
    assert(b == 0, "Blue must be 0")

    r = 52
    g = 235
    b = 225

    int_color = utils.rgb_to_int(r, g, b)
    print(int_color)
    assert(int_color == 3459713)
end

M.test_dim_color = function()
    local int_value = utils.rgb_to_int(255, 255, 255)
    local color = models.Color(int_value, int_value)
    local dimmed_color = eyes.dim_color(color)
    local r, g, b = utils.int_to_rgb(dimmed_color.fg)

    assert(r == 254, "Red must be 254")
    assert(g == 254, "Green must be 254")
    assert(b == 254, "Blue must ber 254")
end

