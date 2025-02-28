return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist)

      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
      else
        print("Warning: cmp-nvim-lsp not found! Run :Lazy sync")
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

      -- Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "tailwindcss", "volar", "eslint" },
        automatic_installation = true,
      })

      -- Setup LSP
      local lspconfig = require("lspconfig")

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      lspconfig.ruff_lsp.setup({
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      -- Python virtual env detection
      local util = require("lspconfig/util")
      local path = util.path or require("lspconfig.util").path

      local function file_exists(name)
        local f = io.open(name, "r")
        if f ~= nil then
          io.close(f)
          return true
        else
          return false
        end
      end

      local function get_python_path(workspace)
        local util = require("lspconfig/util")
        local path = util.path or require("lspconfig.util").path

        -- Check if a virtual environment is activated
        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end

        -- Check if a virtual environment exists in the workspace
        for _, pattern in ipairs({ "*", ".*" }) do
          local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
          if match and match ~= "" then
            return path.join(path.dirname(match), "bin", "python")
          end
        end

        -- Check a default virtual environment location
        local default_venv_path = path.join(vim.env.HOME, "virtualenvs", "nvim-venv", "bin", "python")
        if file_exists(default_venv_path) then
          return default_venv_path
        end

        -- Get system Python
        local system_python = vim.fn.exepath("python3") or vim.fn.exepath("python")
        if system_python and system_python ~= "" then
          return system_python
        end

        -- Fallback: Hardcoded system Python path
        return "/usr/bin/python3"
      end

      lspconfig.pyright.setup({
        capabilities = capabilities,
        before_init = function(_, config)
          config.settings.python.pythonPath = get_python_path(config.root_dir)
        end,
      })

      -- Enable keymaps for LSP
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
      require("lspconfig").pyright.setup({
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off", -- 🔥 Disables strict type checking
              autoImportCompletions = true, -- Improves auto-import suggestions
              useLibraryCodeForTypes = true, -- Helps with Pandas type inference
            },
            formatting = {
              provider = "black",
            },
          },
        },
      })

      -- Enable Fidget for LSP Status
      require("fidget").setup({})
    end,
  },
}
