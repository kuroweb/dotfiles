-- Catppuccin colorscheme
-- flavours: latte (light), frappe, macchiato, mocha (dark)
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        integrations = {
          barbar = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
