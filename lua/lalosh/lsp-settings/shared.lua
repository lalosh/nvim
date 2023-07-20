local M = {}

-------------------------
-------------------------
-------------------------


local function lsp_highlight_document(client)
  --Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_exec(
      [[
       augroup lsp_document_highlight
         autocmd! * <buffer>
         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
       augroup END
     ]],
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

  -- autoformat
  --keymap("n", "<F3>", "<cmd>lua vim.lsp.buf.format()<cr>", opts)

  vim.keymap.set("n", "<F3>", vim.lsp.buf.format, opts)



  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end



local function setupDiagnostics()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
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






local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-------------------------
-------------------------
-------------------------


M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  lsp_highlight_document(client)

  setupDiagnostics()

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", })
end


M.capabilities = capabilities;

M.lsp_keymaps = lsp_keymaps;

return M;
