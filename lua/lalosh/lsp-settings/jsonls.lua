local schemas = {
  {
    description = "NPM configuration file",
    fileMatch = { "package.json" },
    url = "https://json.schemastore.org/package.json",
  },
}

local M = {}

M.settings = function()
  vim.lsp.config('jsonls', {
    settings = {
      json = {
        schemas = schemas,
      },
    },
  })
end

return M
