require('nvim-treesitter.configs').setup {
    ensure_installed = {},
    sync_install = false,
    auto_install = true,
    highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = false },
    parser_install_dir = vim.fn.stdpath('data') .. '/site/parser',
}
