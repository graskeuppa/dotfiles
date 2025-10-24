return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          {
            title = "The world is as big as you want it to be.\nWhere will you go next?\n",
            section = "terminal",
            cmd = "chafa ~/dotfiles/backgrounds/.config/backgrounds/mtebott.jpg --format symbols --symbols vhalf --size 54x15 --stretch; sleep .1",
            height = 15,
            padding = 1,
          },
          {
            pane = 2,
            { title = "What will it be today?\n", section = "keys", indent = 2, padding = 0 },
            { title = "\nJump back into\n", section = "projects", indent = 2, padding = 0 },
            --{ section = "startup" },
          },
        },
      },
    },
  },
}
