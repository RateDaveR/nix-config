local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Disable all highlighting
    client.server_capabilities.documentHighlightProvider = false
    -- Disable semantic tokens
    client.server_capabilities.semanticTokensProvider = nil
end

-- C/C++/CUDA
lspconfig.clangd.setup {
    on_attach = on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = function() end,
    },
    file_types = {"c", "cpp", "cuda"},
    init_options = {
        highlight = {
            lsRanges = false,
        }
    },
}

-- Python
lspconfig.pyright.setup {
    on_attach = on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = function() end,
    },
    file_types = {"python"},
    init_options = {
        highlight = {
            lsRanges = false,
        }
    },
}

-- TypeScript/JavaScript
lspconfig.ts_ls.setup {
    on_attach = on_attach,
}

-- Go
lspconfig.gopls.setup {
    on_attach = on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = function() end,
    },
    file_types = {"go"},
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
    },
}

