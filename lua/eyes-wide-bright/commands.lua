local eyes = require("eyes-wide-bright.eyes")
local config = require("eyes-wide-bright.config")
local utils = require("eyes-wide-bright.utils")
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


    vim.api.nvim_create_user_command(
        'EyesMode',
        function(opts)
            local modes = {"normal", "cold", "warm"}
            if (utils.contains_array(modes, opts.args) == false) then
                print("Invalid mode")
                return
            end

            config.build_config({
                mode = opts.args
            })
        end,
        {nargs = 1}
    )
end

return M
