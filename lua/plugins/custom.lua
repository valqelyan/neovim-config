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
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {},
  },

  { "wnkz/monoglow.nvim" },
  --
  -- {
  --
  --   "masisz/wisteria.nvim",
  --   name = "wisteria",
  --   opts = {
  --     transparent = true,
  --   },
  -- },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      highlight_overrides = {
        all = function(colors)
          return {
            CursorLine = { bg = "#1e1830" },
          }
        end,
      },
      term_colors = true,
      transparent_background = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        harpoon = true,
        telescope = true,
        mason = true,
        noice = true,
        notify = true,
        which_key = true,
        fidget = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },

            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },

          inlay_hints = {
            background = true,
          },
        },
      },

      flavour = "mocha",
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "ys", -- Add surrounding
        delete = "ds", -- Delete surrounding
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
      require("better_escape").setup({
        mappings = {
          t = {
            j = {
              k = false,
            },
          },
        },
      })
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
    autoformat = false,
    diagnostics = {
      virtual_text = false,
    },
  },
  config = function(_, opts)  -- ← receive opts as second argument
    -- Apply diagnostics config
    vim.diagnostic.config(opts.diagnostics)

    -- Your autocmd
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.keymap.del("n", "K", { buffer = args.buf })
      end,
    })
  end,
},

  {
    "lkzz/golden-ratio.nvim",
    config = function()
      local gr = require("golden-ratio")
      gr.setup({})
      gr.enable()
    end,
  },

  {
    "homerours/jumper.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- If using Telescope as backend:
      local jumper = require("telescope").extensions.jumper
      -- -- or, if using fzf-lua as backend:
      -- local jumper = require("jumper.fzf-lua")

      -- Configure bindings to launch the pickers:
      vim.keymap.set("n", "<leader>fu", jumper.find_in_files)
    end,
  },
}
