return {
  {
    "vinnymeller/swagger-preview.nvim",
    run = "npm install -g swagger-ui-watcher",
    init = function()
      require("swagger-preview").setup({
        port = 8000,
        host = "localhost",
      })
    end,
  },
}
