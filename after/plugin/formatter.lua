
require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {

    json = {
      require("formatter.filetypes.json").prettierd
    },
    html = {
      require("formatter.filetypes.html").prettierd
    },
    javascript = {
      require("formatter.filetypes.javascriptreact").prettierd
    },
    javascriptreact = {
      require("formatter.filetypes.javascriptreact").prettierd
    },

    typescript= {
      require("formatter.filetypes.javascriptreact").prettierd
    },
    typescriptreact = {
      require("formatter.filetypes.javascriptreact").prettierd
    },

  }
}


