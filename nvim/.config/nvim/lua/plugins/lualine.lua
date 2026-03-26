return {
  {
    "nvim-lualine/lualine.nvim",

    opts = {

      options = {

        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            function()
              local mode_map = {
                ["n"] = "N",
                ["i"] = "I",
                ["v"] = "V",
                ["V"] = "VL",
                ["\22"] = "VB", -- Visual Block mode
                ["c"] = "C",
                ["R"] = "R",
                ["t"] = "T",
              }
              local mode = vim.api.nvim_get_mode().mode
              return mode_map[mode] or ""
            end,
            separator = { left = "" },
            right_padding = 2,
          },
        },
        lualine_b = {

          LazyVim.lualine.root_dir(),
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_c = {},
        lualine_x = {
          {
            "diagnostics",
          },
        },
        lualine_y = {
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        },
        lualine_z = {
          { "branch", icon = "", separator = { right = "" } },
        },
      },
    },
  },
}
