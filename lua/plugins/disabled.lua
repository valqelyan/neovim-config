return {
  -- disable trouble
  { "nvim-lualine/lualine.nvim", enabled = false },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    enabled = false,
  },

  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>n", mode = { "n" }, false },
    },
    opts = {
      dashboard = { enabled = false },
      marks = { enabled = false },
      explorer = { enabled = false },
    },
  },
}
