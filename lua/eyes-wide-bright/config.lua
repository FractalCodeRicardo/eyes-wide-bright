local M = {}

M._current_config = nil;

M.default_config = function ()
    return {
        mode = 'normal',
        increase_key = '<leader>m',
        decrease_key = '<leader>l',
        reset_key = '<leader>r'
    }
end

M.get_current_config = function ()
    if M._current_config == nil then
        M._current_config = M.default_config()
    end

    return M._current_config;
end

M.build_config= function (user_config)

    local config = M.get_current_config()

    if user_config == nil then
        return config
    end

    config.decrease_key = user_config.decrease_key or
    config.decrease_key

    config.increase_key = user_config.increase_key or
    config.increase_key

    config.reset_key = user_config.reset_key or
    config.reset_key

    config.mode = user_config.mode or config.mode

    M._current_config = config;

    return config
end

return M
