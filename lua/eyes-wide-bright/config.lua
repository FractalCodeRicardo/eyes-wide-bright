local M = {}

M.default_config = function ()
    return {
        increase_key = '<leader>m',
        decrease_key = '<leader>l',
        reset_key = '<leader>r'
    }
end

M.build_config= function (user_config)
    local default = M.default_config()

    if user_config == nil then
        return default
    end

    default.decrease_key = user_config.decrease_key or
    default.decrease_key

    default.increase_key = user_config.increase_key or
    default.increase_key

    default.reset_key = user_config.reset_key or
    default.reset_key

end

return M
