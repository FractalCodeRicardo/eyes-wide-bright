local config = require("eyes-wide-bright.config")
local keys = require("eyes-wide-bright.keymaps")
local commands = require("eyes-wide-bright.commands")
local M = {}

function M.setup(user_config)
    local current_config = config.build_config(user_config)
    keys.init_keymaps(current_config)
    commands.init_commands()
end

return M
