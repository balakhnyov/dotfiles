return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist)

      -- Setup nvim-cmp
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Setup Mason with improved error handling
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
        },
        PATH = "prepend", -- Ensure Mason binaries are found first
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "tailwindcss", "volar", "eslint" },
        automatic_installation = {
          ignore = {}, -- Empty list means install all missing servers
          interval = 15, -- Check interval in minutes
          retry = true, -- Retry failed installations
        },
      })

      -- Setup LSP
      local lspconfig = require("lspconfig")

      -- Common LSP setup
      local on_attach = function(_, bufnr)
        local function nmap(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        nmap("<leader>lf", vim.lsp.buf.format, "[L]SP [F]ormat")
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("gt", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      end

      -- Python LSP setup
      local function get_python_path(workspace)
        -- Conda environment (base or others)
        if vim.env.CONDA_PREFIX then
          return vim.env.CONDA_PREFIX .. "/bin/python"
        end
        -- fallback to virtualenv
        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end
        -- fallback to .venv in project
        local match = vim.fn.glob(workspace .. "/.venv/bin/python")
        if match ~= "" then
          return match
        end
        -- system default
        return "python3"
      end

      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        before_init = function(_, config)
          config.settings.python.pythonPath = get_python_path(config.root_dir)
        end,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              autoImportCompletions = true,
              useLibraryCodeForTypes = true,
            },
            formatting = {
              provider = "black",
            },
          },
        },
      })

      -- Other LSP servers
      lspconfig.ruff_lsp.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })

      -- Enable Fidget for LSP Status
      require("fidget").setup({})
    end,
  },

  -- Additional LSP-related plugins
  { "onsails/lspkind.nvim" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
}
