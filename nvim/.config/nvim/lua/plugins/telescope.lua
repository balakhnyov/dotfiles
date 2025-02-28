return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- 🔥 Add this
  },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    })

    -- Load FZF extension 🔥
    require("telescope").load_extension("fzf")
  end,
}
