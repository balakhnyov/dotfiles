return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Get capabilities from blink.cmp (LazyVim default) or fallback
      local capabilities
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = blink.get_lsp_capabilities()
      else
        capabilities = vim.lsp.protocol.make_client_capabilities()
      end

      -- Setup Mason
      require("mason").setup({
        registries = { "github:mason-org/mason-registry" },
        PATH = "prepend",
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff", "tailwindcss", "vtsls", "eslint" },
        automatic_installation = true,
      })

      -- Shared on_attach function (LSP keymaps)
      local on_attach = function(_, bufnr)
        local function nmap(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("gd", vim.lsp.buf.definition, "Goto Definition")
        nmap("gt", vim.lsp.buf.type_definition, "Type Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        nmap("<leader>lf", vim.lsp.buf.format, "Format Buffer")

        -- Telescope-based LSP lookups (wrapped in functions for lazy-loading safety)
        nmap("gr", function() require("telescope.builtin").lsp_references() end, "Goto References")
        nmap("<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, "Document Symbols")
        nmap("<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "Workspace Symbols")

        -- Diagnostic keymaps
        nmap("<leader>dp", vim.diagnostic.goto_prev, "Prev Diagnostic")
        nmap("<leader>dn", vim.diagnostic.goto_next, "Next Diagnostic")
        nmap("<leader>dd", vim.diagnostic.open_float, "Line Diagnostic")
        nmap("<leader>dl", vim.diagnostic.setloclist, "Diagnostic List")
      end

      -- Python Venv Detection (supports uv, conda, virtualenv, venv)
      local function get_python_path(workspace)
        -- 1. uv custom environment (UV_PROJECT_ENVIRONMENT=path/to/venv)
        if vim.env.UV_PROJECT_ENVIRONMENT then
          local uv_python = vim.env.UV_PROJECT_ENVIRONMENT .. "/bin/python"
          if vim.fn.executable(uv_python) == 1 then
            return uv_python
          end
        end
        -- 2. Conda
        if vim.env.CONDA_PREFIX then
          return vim.env.CONDA_PREFIX .. "/bin/python"
        end
        -- 3. Active virtualenv (also set by `uv run`)
        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end
        -- 4. Project-local .venv (default for uv venv / python -m venv)
        local venv = vim.fn.glob(workspace .. "/.venv/bin/python")
        if venv ~= "" then
          return venv
        end
        -- 5. Fallback: venv/ directory
        local venv2 = vim.fn.glob(workspace .. "/venv/bin/python")
        if venv2 ~= "" then
          return venv2
        end
        return "python3"
      end

      -- Server Setup
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
          },
        },
      })

      lspconfig.ruff.setup({ capabilities = capabilities, on_attach = on_attach })

      -- TypeScript: ts_ls (modern) with fallback to tsserver (legacy)
      if lspconfig.ts_ls then
        lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
      else
        lspconfig.tsserver.setup({ capabilities = capabilities, on_attach = on_attach })
      end

      -- Fidget (Status notifications)
      require("fidget").setup({})
    end,
  },
}
