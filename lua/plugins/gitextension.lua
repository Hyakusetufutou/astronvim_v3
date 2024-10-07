return {
  -- {
  --   "tpope/vim-fugitive",
  --   cmd = {"G", "Git", "Git diff", "Gdiffsplit","Gvdiffsplit", "Glog", "Gclogu" },
  --   config = function ()
  --     
  --   end
  -- },
  -- {
  --   'dinhhuy258/git.nvim',
  --   cmd = {"GitDiff"},
  --   config = function()
  --     require('git').setup()
  --   end,
  -- },
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { winbar_info = true },
        file_history = { winbar_info = true },
      },
      hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
    },
    specs = {
      {
        "NeogitOrg/neogit",
        optional = true,
        opts = { integrations = { diffview = true } },
      },
    },
  },
  {
    "isakbm/gitgraph.nvim",
    lazy = true,
    opts = {
      symbols = {
        merge_commit = '●',
        commit = '*',
      },
      format = {
        timestamp = '%Y-%m-%d %H:%M:%S ',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
    },
    specs = {
      { -- use diffview for viewing commits if available
        "sindrets/diffview.nvim",
        optional = true,
        specs = {
          {
            "isakbm/gitgraph.nvim",
            opts = {
              hooks = {
                on_select_commit = function(commit) vim.cmd.DiffviewOpen(commit.hash .. "^!") end,
                on_select_range_commit = function(from, to) vim.cmd.DiffviewOpen(from.hash .. "~1.." .. to.hash) end,
              },
            },
          },
        },
      },
    },
  },
}
