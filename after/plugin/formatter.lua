
require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {

    javascript = {
      require("formatter.filetypes.javascriptreact").prettierd
    },
    javascriptreact = {
      require("formatter.filetypes.javascriptreact").prettierd
    },

    typescrip= {
      require("formatter.filetypes.javascriptreact").prettierd
    },
    typescriptreact = {
      require("formatter.filetypes.javascriptreact").prettierd
    },

  }
}


