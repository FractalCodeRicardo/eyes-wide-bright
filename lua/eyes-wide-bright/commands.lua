local eyes = require("eyes-wide-bright.eyes")
local M = {}

M.init_commands = function()
    -- Simple command in Lua
    vim.api.nvim_create_user_command(
        'EyesIncrease',
        function()
            eyes.bright_theme()
        end,
        {}
    )


    vim.api.nvim_create_user_command(
        'EyesDecrease',
        function()
            eyes.dim_theme()
        end,
        {}
    )


    vim.api.nvim_create_user_command(
        'EyesReset',
        function()
            eyes.restore_theme()
        end,
        {}
    )
end

return M
