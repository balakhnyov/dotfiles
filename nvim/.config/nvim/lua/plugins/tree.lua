return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  requires = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({})

    -- 🔥 Smart toggle between `nvim-tree` and the last buffer
    local api = require("nvim-tree.api")
    local function toggle_nvim_tree()
      if vim.bo.filetype == "NvimTree" then
        vim.cmd("wincmd p") -- Go back to the previous window
      else
        api.tree.focus()
      end
    end
    vim.keymap.set("n", "<leader>tt", toggle_nvim_tree, { desc = "Toggle NvimTree Focus" })
  end,
}
