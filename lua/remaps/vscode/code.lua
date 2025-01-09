require('remaps.vscode.jumps')
require('remaps.vscode.utils')

vim.keymap.set({ 'n' }, 'gd',
    function()
        register_jump()
        vsc_notify('editor.action.revealDefinition')
    end
)

vim.keymap.set({ 'n' }, 'gD',
    function()
        register_jump()
        vsc_notify('editor.action.goToTypeDefinition')
    end
)

vim.keymap.set({ 'n' }, 'gI',
    function()
        register_jump()
        vsc_notify('editor.action.goToImplementation')
    end
)

vim.keymap.set({ 'n' }, 'gr',
    function()
        register_jump()
        vsc_notify('editor.action.referenceSearch.trigger')
    end
)

vim.keymap.set({ 'n' }, 'gs',
    function()
        register_jump()
        vsc_notify('workbench.action.gotoSymbol')
    end
)

vim.keymap.set({ 'n' }, 'gp',
    function()
        register_jump()
        vsc_notify('go-to-next-error.next.error')
    end
)

vim.keymap.set({ 'n' }, 'gP',
    function()
        register_jump()
        vsc_notify('go-to-next-error.prev.error')
    end
)

vim.keymap.set({ 'n' }, '<leader>r',
    function()
        vsc_notify('editor.action.rename')
    end
)

vim.keymap.set({ 'n' }, 'K',
    function()
        vsc_notify('editor.action.showDefinitionPreviewHover')
    end
)

vim.keymap.set({ 'n' }, '<leader>fs',
    function()
        register_jump()
        vsc_notify('workbench.action.showAllSymbols')
    end
)

vim.keymap.set({ 'n' }, '<leader>fe',
    function()
        register_jump()
        vsc_notify('search.action.openEditor')
    end
)

vim.keymap.set({ 'n' }, '<leader>ff',
    function()
        register_jump()
        vsc_notify('workbench.action.quickTextSearch')
    end
)
