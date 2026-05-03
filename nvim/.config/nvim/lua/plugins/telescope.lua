return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-symbols.nvim",
  },
  cmd = "Telescope",
  -- Keymaps defined here enable lazy-loading (plugin loads on first keypress)
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
    { "<leader>fs", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Search in buffer" },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
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

    -- Load FZF extension (pcall prevents crash if not compiled)
    pcall(telescope.load_extension, "fzf")
  end,
}
