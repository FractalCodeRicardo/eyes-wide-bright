local eyes = require("eyes-wide-bright.eyes")
local M = {}

M.init_keymaps = function (config)
    vim.keymap.set("n", config.increase_key, function()
        eyes.bright_theme()
    end, { desc = "Increase brightness" })

    vim.keymap.set("n", config.decrease_key, function()
        eyes.dim_theme()
    end, { desc = "Decrease brightness" })

    vim.keymap.set("n", config.reset_key, function()
        eyes.restore_theme()
    end, { desc = "Reload theme" })
end

return M
