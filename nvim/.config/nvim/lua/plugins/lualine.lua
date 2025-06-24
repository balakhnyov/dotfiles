return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "ellisonleao/gruvbox.nvim", -- 👈 this ensures it's loaded first
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
        theme = "gruvbox", -- now this should be safe!
      },
      sections = {
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_a = {
          {
            "buffers",
          },
        },
      },
    })
  end,
}
