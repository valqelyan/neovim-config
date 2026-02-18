return {
  {
    "luukvbaal/nnn.nvim",
    event = "VimEnter",
    keys = {
      { "<leader>n", "<cmd>NnnPicker %:p:h<CR>", desc = "Toggle nnn" },
    },
    config = function()
      local builtin = require("nnn").builtin

      require("nnn").setup({
        auto_open = {
          setup = "picker",
          tabpage = "picker",
          empty = true,
        },

        replace_netrw = "picker",
        mappings = {
          { "<C-t>", builtin.open_in_tab },
          { "<C-h>", builtin.open_in_split },
          { "<C-v>", builtin.open_in_vsplit },
          { "<C-p>", builtin.open_in_preview },
          { "<C-y>", builtin.copy_to_clipboard },
          { "<C-w>", builtin.cd_to_path },
          { "<C-e>", builtin.populate_cmdline },
        },
        picker = {
          cmd = "nnn",
          style = {
            width = 0.5,
            height = 0.5,
            xoffset = 0.5,
            yoffset = 0.5,
            border = "rounded",
          },
          session = "",
          tabs = true,
          fullscreen = false,
        },
      })
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "mm", function()
        harpoon:list():add()
      end)

      vim.keymap.set("n", "ml", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      local function setup_harpoon_keymaps()
        local map = vim.keymap.set
        local list = harpoon:list()

        for index, item in ipairs(list.items) do
          local basename = item.value:match("[^/]+$")
          local first_letter = basename:sub(1, 1)

          if first_letter ~= "l" then
            map("n", "m" .. first_letter, function()
              harpoon:list():select(index)
            end)
          end
        end
      end

      setup_harpoon_keymaps()

      vim.keymap.set("n", "mr", setup_harpoon_keymaps)
    end,
  },

  { "wnkz/monoglow.nvim" },

  {

    "masisz/wisteria.nvim",
    name = "wisteria",
    opts = {
      transparent = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "wisteria",
    },
  },

  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "ys",     -- Add surrounding
        delete = "ds",  -- Delete surrounding
        replace = "cs", -- Replace surrounding
      },
    },
  },

  {
    "stevearc/overseer.nvim",
    opts = {},
  },

  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "soulis-1256/eagle.nvim",
    opts = {
      keyboard_mode = true,
    },
    keys = {
      { "H", ":EagleWin<CR>", mode = "n", noremap = true, silent = true },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },

  {
    "lkzz/golden-ratio.nvim",
    config = function()
      local gr = require("golden-ratio")
      gr.setup({})
      gr.enable()
    end
  }
}
