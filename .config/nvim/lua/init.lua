
vim.opt.termguicolors = true
-- vim.g.tokyonight_style = "storm"
-- vim.g.sonokai_style = "espresso"

-- vim.cmd [[highlight IndentBlanklineChar guibg=#696969  gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#696969 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineSpaceCharBlankline guibg=#696969  gui=nocombine]]
vim.opt.list = true
-- Useful but too much noise.
-- How to make the color blends nicely in background like vscode? Some theme is fine
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup{
    show_end_of_line = true,
    show_trailing_blankline_indent = false,
    space_char_blankline = " ",
    -- char_highlight_list = {
    --     "IndentBlanklineChar",
    -- }
}

