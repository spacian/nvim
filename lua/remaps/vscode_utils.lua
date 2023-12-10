function nvim_feedkeys(keys)
    local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

function vsc_call(arg)
    nvim_feedkeys(string.format(':call %s<enter>', arg))
end

function vsc_notify(arg)
    vsc_call(string.format('VSCodeNotify("%s")', arg))
end

function center()
    vsc_notify('center-editor-window.center')
end
