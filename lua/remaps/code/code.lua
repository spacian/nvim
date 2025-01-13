require('remaps.code.jumps')
require('remaps.code.utils')

vim.keymap.set({ 'n' }, 'gd',
    function()
        Register_jump()
        Vsc_notify('editor.action.revealDefinition')
    end
)

vim.keymap.set({ 'n' }, 'gD',
    function()
        Register_jump()
        Vsc_notify('editor.action.goToTypeDefinition')
    end
)

vim.keymap.set({ 'n' }, 'gI',
    function()
        Register_jump()
        Vsc_notify('editor.action.goToImplementation')
    end
)

vim.keymap.set({ 'n' }, 'gr',
    function()
        Register_jump()
        Vsc_notify('editor.action.referenceSearch.trigger')
    end
)

vim.keymap.set({ 'n' }, 'gs',
    function()
        Register_jump()
        Vsc_notify('workbench.action.gotoSymbol')
    end
)

vim.keymap.set({ 'n' }, 'gp',
    function()
        Register_jump()
        Vsc_notify('go-to-next-error.next.error')
    end
)

vim.keymap.set({ 'n' }, 'gP',
    function()
        Register_jump()
        Vsc_notify('go-to-next-error.prev.error')
    end
)

vim.keymap.set({ 'n' }, '<leader>r',
    function()
        Vsc_notify('editor.action.rename')
    end
)

vim.keymap.set({ 'n' }, 'K',
    function()
        Vsc_notify('editor.action.showDefinitionPreviewHover')
    end
)

vim.keymap.set({ 'n' }, '<leader>fs',
    function()
        Register_jump()
        Vsc_notify('workbench.action.showAllSymbols')
    end
)

vim.keymap.set({ 'n' }, '<leader>fe',
    function()
        Register_jump()
        Vsc_notify('search.action.openEditor')
    end
)

vim.keymap.set({ 'n' }, '<leader>ff',
    function()
        Register_jump()
        Vsc_notify('workbench.action.quickTextSearch')
    end
)
