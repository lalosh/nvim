local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("lspconfig is not installed")
  return;
end


local shared_lsp_settings = require("lalosh.lsp-settings.shared")

local M = {}

M.settings = function()
  lspconfig.ts_ls.setup {
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
          includeInlayEnumMemberValueHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayVariableTypeHints = false,
        },
      }
    },
  }
end


local opts = { noremap = true, silent = true }


-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local function lsp_organize_imports()
  local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
  vim.lsp.buf.execute_command(params)
end

vim.keymap.set("n", "gO", lsp_organize_imports, opts);

return M
