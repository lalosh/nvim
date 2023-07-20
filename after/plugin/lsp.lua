require("mason").setup()
local lspconfig = require("lspconfig")

local shared_lsp_settings = require("lalosh.lsp-settings.shared")

local jsonls_lsp_settings = require("lalosh.lsp-settings.jsonls").settings;
local luals_lsp_settings = require("lalosh.lsp-settings.luals").settings;
local tsserver_lsp_settings = require("lalosh.lsp-settings.tsserver").settings;


local status_ok, _ = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify('cmp_nvim_lsp is not installed')
  return
end




require("mason-lspconfig").setup_handlers {

  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,

  ["jsonls"] = jsonls_lsp_settings,
  ["lua_ls"] = luals_lsp_settings,
  ["tsserver"] = tsserver_lsp_settings,

}
