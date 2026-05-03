-- Miscellaneous plugins
-- Dedicated plugin files: lsp.lua, telescope.lua, colorscheme.lua, lualine.lua, iron.lua, tree.lua

return {
  -- UI & Icons
  { "ziontee113/icon-picker.nvim", opts = { disable_legacy_commands = true } },
  { "ryanoasis/vim-devicons" },
  { "folke/zen-mode.nvim" },
  { "folke/twilight.nvim", opts = {} },
  { "catppuccin/nvim", name = "catppuccin" },

  -- Git
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Coding Utilities
  { "tpope/vim-surround" },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Downloads" },
    },
  },
  { "rmagatti/goto-preview", opts = {} },

  -- Treesitter (extend LazyVim defaults with extra languages)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python", "lua", "markdown", "markdown_inline", "sql" },
    },
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- Bufferline
  { "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Noice (UI improvements)
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
            },
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = false,
      },
    },
  },

  -- Leetcode
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lang = "python",
    },
  },

  -- Database (Dadbod)
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
    end,
  },

  -- AI (Avante)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    opts = {
      provider = "openrouter",
      providers = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "deepseek/deepseek-r1",
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    init = function()
      vim.opt.laststatus = 3
    end,
  },
}
