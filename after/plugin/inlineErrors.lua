require("tiny-inline-diagnostic").setup({
    transparent_bg = false,
    options = {
        multilines = {
            enabled = true,
        },
    },
    multilines = {
        enabled = false,           -- Enable support for multiline diagnostic messages
        always_show = false,       -- Always show messages on all lines of multiline diagnostics
        trim_whitespaces = false,  -- Remove leading/trailing whitespace from each line
        tabstop = 4,               -- Number of spaces per tab when expanding tabs
        severity = nil,            -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
    },
    show_all_diags_on_cursorline = false,
})

