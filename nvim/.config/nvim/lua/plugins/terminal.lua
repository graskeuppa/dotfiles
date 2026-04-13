return {

  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      terminal = {

        win = {
          -- title = "Look into the mirror",
          -- title_pos = "center",
          position = "float",
          border = "rounded",
          width = 0.7,
          height = 0.5,
          -- col = 0.9,
          -- row = 0,
        },
      },
    },
  },
}
