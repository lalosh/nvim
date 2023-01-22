require("mason").setup()
local lspconfig = require("lspconfig")


local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

local function lsp_keymaps(bufnr)

  local opts = { noremap = true, silent = true }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local function setup()


  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end




  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

end

local function on_attach(client, bufnr)

  lsp_keymaps(bufnr)

  lsp_highlight_document(client)

  setup()

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", })

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify('cmp_nvim_lsp is not installed')
  return
end




local schemas = {
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
}

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:

  ["jsonls"] = function()
    lspconfig.jsonls.setup {
      on_attach = function(client, bufnr)
        lsp_keymaps(bufnr);
      end,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = schemas,
        },
      },
    }
  end,

  ["tsserver"] = function()
    lspconfig.tsserver.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,

  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        }
      }
    }
  end
}
