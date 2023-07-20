local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("lspconfig is not installed")
  return;
end


local shared_lsp_settings = require("lalosh.lsp-settings.shared")

local M = {}

M.settings = function()
  lspconfig.tsserver.setup {
    on_attach = shared_lsp_settings.on_attach,
    capabilities = shared_lsp_settings.capabilities,
    settings = {
      implicitProjectConfiguration = {
        checkJs = true
      },
      completions = {
        completeFunctionCalls = true,
      },
      typescript = {
        format = {
          baseIndentSize = 0,
          indentSize = 2,
          convertTabsToSpaces = false,
          semicolons = "insert",
          tabSize = 2,
        },
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      }
    },
  }
end


return M
