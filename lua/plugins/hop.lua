return {
  {
    "phaazon/hop.nvim",
    opts = {},
    keys = {
      {
        "gs",
        function() require("hop").hint_words() end,
        mode = { "n" },
        desc = "Hop hint words",
      },
      {
        "gs",
        function() require("hop").hint_words { extend_visual = true } end,
        mode = { "v" },
        desc = "Hop hint words",
      },
    },
  },
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { hop = true } },
  },
}
