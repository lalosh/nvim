local status_ok, _ = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify('cmp_nvim_lsp is not installed')
  return
end

local shared_lsp_settings = require("lalosh.lsp-settings.shared")

-- Set global defaults (capabilities) for all servers
vim.lsp.config('*', {
  capabilities = shared_lsp_settings.capabilities,
})

require("mason").setup()
require("mason-lspconfig").setup()

-- Configure specific servers explicitly
require("lalosh.lsp-settings.jsonls").settings()
require("lalosh.lsp-settings.luals").settings()
require("lalosh.lsp-settings.tsserver").settings()

-- Apply on_attach/keymaps to all LSP clients (including auto-enabled ones)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      shared_lsp_settings.on_attach(client, args.buf)
    end
  end,
})
