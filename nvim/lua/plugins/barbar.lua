-- バッファをタブのように表示する (barbar.nvim)
return {
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    keys = {
      { "<Leader>bp", "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
      { "<Leader>bn", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
      { "<Leader>bc", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
      { "<Leader>bo", "<Cmd>BufferCloseAllExceptCurrent<CR>", desc = "Close other buffers" },
      { "<Leader>bq", "<Cmd>BufferPick<CR>", desc = "Pick buffer (jump by letter)" },
      { "<Leader>b1", "<Cmd>BufferGoto 1<CR>", desc = "Goto buffer 1" },
      { "<Leader>b2", "<Cmd>BufferGoto 2<CR>", desc = "Goto buffer 2" },
      { "<Leader>b3", "<Cmd>BufferGoto 3<CR>", desc = "Goto buffer 3" },
      { "<Leader>b4", "<Cmd>BufferGoto 4<CR>", desc = "Goto buffer 4" },
      { "<Leader>b5", "<Cmd>BufferGoto 5<CR>", desc = "Goto buffer 5" },
    },
    opts = {
      animation = true,
      clickable = true,
      icons = {
        filetype = { enabled = true },
      },
      sidebar_filetypes = {
        NvimTree = true,
      },
    },
    config = function(_, opts)
      require("barbar").setup(opts)
    end,
  },
}
