function nvim_feedkeys(keys)
    local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

function call(arg)
    nvim_feedkeys(string.format(':call %s<enter>', arg))
end

function vsc_notify(arg)
    call(string.format('VSCodeNotify("%s")', arg))
end

function vsc_call(arg)
    call(string.format('VSCodeCall("%s")', arg))
end

function center()
    vsc_notify('center-editor-window.center')
end

function register_jump(i)
    i = i or ''
    vsc_call('jumplist.registerJump' .. i)
end

function jump_back(i)
    i = i or ''
    vsc_call('jumplist.jumpBack' .. i)
end

function jump_forw(i)
    i = i or ''
    vsc_call('jumplist.jumpForward' .. i)
end
