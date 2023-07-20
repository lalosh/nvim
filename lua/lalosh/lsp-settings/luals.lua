local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
 vim.notify("lspconfig is not installed")
 return;
end

local shared_lsp_settings = require("lalosh.lsp-settings.shared")

local M = {}


M.settings = function()
  lspconfig.lua_ls.setup {
    on_attach = shared_lsp_settings.on_attach,
    capabilities = shared_lsp_settings.capabilities,
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

return M;
