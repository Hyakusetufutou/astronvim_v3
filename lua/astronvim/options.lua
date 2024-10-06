vim.opt.viewoptions:remove "curdir" -- disable saving current directory with views
vim.opt.shortmess:append { s = true, I = true } -- disable search count wrap and startup messages
vim.opt.backspace:append { "nostop" } -- don't stop backspace at insert
if vim.fn.has "nvim-0.9" == 1 then
  vim.opt.diffopt:append "linematch:60" -- enable linematch diff algorithm
end
local options = astronvim.user_opts("options", {
  opt = {
    breakindent = true, -- wrap indent to match  line start
    clipboard = "unnamedplus", -- connection to the system clipboard
    cmdheight = 0, -- hide command line unless needed
    completeopt = { "menu", "menuone", "noselect" }, -- Options for insert mode completion
    copyindent = true, -- copy the previous indentation on autoindenting
    cursorline = true, -- highlight the text line of the cursor
    expandtab = true, -- enable the use of space in tab
    fileencoding = "utf-8", -- file content encoding for the buffer
    fillchars = { eob = " " }, -- disable `~` on nonexistent lines
    foldenable = true, -- enable fold for nvim-ufo
    foldlevel = 99, -- set high foldlevel for nvim-ufo
    foldlevelstart = 99, -- start with all code unfolded
    foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil, -- show foldcolumn in nvim 0.9
    history = 100, -- number of commands to remember in a history table
    ignorecase = true, -- case insensitive searching
    infercase = true, -- infer cases in keyword completion
    laststatus = 3, -- global statusline
    linebreak = true, -- wrap lines at 'breakat'
    mouse = "a", -- enable mouse support
    number = true, -- show numberline
    preserveindent = true, -- preserve indent structure as much as possible
    pumheight = 10, -- height of the pop up menu
    relativenumber = false, -- show relative numberline
    shiftwidth = 2, -- number of space inserted for indentation
    showmode = false, -- disable showing modes in command line
    showtabline = 2, -- always display tabline
    signcolumn = "yes", -- always show the sign column
    smartcase = true, -- case sensitive searching
    splitbelow = true, -- splitting a new window below the current one
    splitright = true, -- splitting a new window at the right of the current one
    tabstop = 2, -- number of space in a tab
    termguicolors = true, -- enable 24-bit RGB color in the TUI
    timeoutlen = 500, -- shorten key timeout length a little bit for which-key
    title = true, -- set terminal title to the filename and path
    undofile = true, -- enable persistent undo
    updatetime = 300, -- length of time to wait before triggering the plugin
    virtualedit = "block", -- allow going past end of line in visual block mode
    wrap = false, -- disable wrapping of lines longer than the width of window
    writebackup = false, -- disable making a backup before overwriting a file
  },
  g = {
    mapleader = " ", -- set leader key
    maplocalleader = ",", -- set default local leader key
    -- AstroNvim specific global options
    max_file = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    autopairs_enabled = true, -- enable autopairs at start
    cmp_enabled = true, -- enable completion at start
    codelens_enabled = true, -- enable or disable automatic codelens refreshing for lsp that support it
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    highlighturl_enabled = true, -- highlight URLs by default
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available)
    inlay_hints_enabled = false, -- enable or disable LSP inlay hints on startup (Neovim v0.10 only)
    lsp_handlers_enabled = true, -- enable or disable default vim.lsp.handlers (hover and signature help)
    semantic_tokens_enabled = true, -- enable or disable LSP semantic tokens on startup
    ui_notifications_enabled = true, -- disable notifications (TODO: rename to  notifications_enabled in AstroNvim v4)
    git_worktrees = nil, -- enable git integration for detached worktrees (specify a table where each entry is of the form { toplevel = vim.env.HOME, gitdir=vim.env.HOME .. "/.dotfiles" })
  },
  t = vim.t.bufs and vim.t.bufs or { bufs = vim.api.nvim_list_bufs() }, -- initialize buffers for the current tab
})

-- vim.cmd([[
--     if &encoding !=# 'utf-8'
--       set encoding=japan
--       set fileencoding=japan
--     endif
--     if has('iconv')
--       let s:enc_euc = 'euc-jp'
--       let s:enc_jis = 'iso-2022-jp'
--       if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
--         let s:enc_euc = 'eucjp-ms'
--         let s:enc_jis = 'iso-2022-jp-3'
--       elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
--         let s:enc_euc = 'euc-jisx0213'
--         let s:enc_jis = 'iso-2022-jp-3'
--       endif
--       if &encoding ==# 'utf-8'
--         let s:fileencodings_default = &fileencodings
--         let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
--         let &fileencodings = &fileencodings .','. s:fileencodings_default
--         unlet s:fileencodings_default
--       else
--         let &fileencodings = &fileencodings .','. s:enc_jis
--         set fileencodings+=utf-8,ucs-2le,ucs-2
--         if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
--           set fileencodings+=cp932
--           set fileencodings-=euc-jp
--           set fileencodings-=euc-jisx0213
--           set fileencodings-=eucjp-ms
--           let &encoding = s:enc_euc
--           let &fileencoding = s:enc_euc
--         else
--           let &fileencodings = &fileencodings .','. s:enc_euc
--         endif
--       endif
--       unlet s:enc_euc
--       unlet s:enc_jis
--     endif
--     if has('autocmd')
--       function! AU_ReCheck_FENC()
--         if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
--           let &fileencoding=&encoding
--         endif
--       endfunction
--       autocmd BufReadPost * call AU_ReCheck_FENC()
--     endif
--   ]])
-- 
for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
