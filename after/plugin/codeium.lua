
vim.api.nvim_call_function("codeium#GetStatusString", {})

vim.g.codeium_no_map_tab = true;

vim.cmd [[
  set statusline+=\{…\}%3{codeium#GetStatusString()}
]]







