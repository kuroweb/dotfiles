-- バッファをタブのように表示する (barbar.nvim)
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    icons = {
      buffer_index = false,
      buffer_number = false,
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
    },
  },
}
