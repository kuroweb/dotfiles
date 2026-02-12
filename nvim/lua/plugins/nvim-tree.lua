-- 左側にフォルダツリーを表示するファイラー (nvim-tree)
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<Leader>f", "<Cmd>NvimTreeFindFile<CR>", desc = "Find current file in tree" },
    },
    opts = {
      view = {
        width = 35,
        side = "left",
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false, -- .で始まるファイルも表示
      },
      git = {
        enable = true,
        ignore = false,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },
}
