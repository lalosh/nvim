
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
 vim.notify("lspconfig is not installed")
 return;
end

local shared_lsp_settings = require("lalosh.lsp-settings.shared")

local schemas = {
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
}


local M = {}

M.settings = function()
  lspconfig.jsonls.setup {
    on_attach = function(_, bufnr)
      shared_lsp_settings.lsp_keymaps(bufnr);
    end,
    capabilities = shared_lsp_settings.capabilities,
    settings = {
      json = {
        schemas = schemas,
      },
    },
  }
end

return M;
