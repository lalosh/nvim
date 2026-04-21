local M = {}

M.settings = function()
  vim.lsp.config('ts_ls', {
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
          includeInlayParameterNameHints = "none",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayVariableTypeHints = false,
        },
      }
    },
  })
end

local function lsp_organize_imports()
  local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
  vim.lsp.buf.execute_command(params)
end

vim.keymap.set("n", "gO", lsp_organize_imports, { noremap = true, silent = true })

return M
