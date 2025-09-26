vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    -- local map = function(keys, func, desc)
    --   vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    -- end
    --
    -- map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
    -- map("K", vim.lsp.buf.hover, "Hover Documentation")
    -- map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
    -- map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    -- map("<leader>la", vim.lsp.buf.code_action, "Code Action")
    -- map("<leader>lr", vim.lsp.buf.rename, "Rename all references")
    -- map("<leader>lf", vim.lsp.buf.format, "Format")
    -- map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")
    --
    vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- enable completion when available
    if client:supports_method("textDocument/completion") then
      -- trigger completion menu on every keypress
      client.server_capabilities.completionProvider.triggerCharacters = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        '1', '2', '3', '4', '5', '6', '7', '8', '9',
        '!', '@', '#', '$', '%', '^', '&', '*',
      }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- auto-format ("lint") on save
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- see `:h completeopt`
vim.opt.completeopt = "fuzzy,menuone,noinsert,popup"
-- map <c-space> to activate completion
vim.keymap.set("i", "<c-space>", function() vim.lsp.completion.get() end)
-- map <cr> to <c-y> when the popup menu is visible and item is selected
vim.keymap.set("i", "<cr>", function()
  local compinfo = vim.fn.complete_info({ "pum_visible", "selected" })
  if compinfo.pum_visible and
      compinfo.selected >= 0 then
    return "<c-y>"
  end
  return "<cr>"
end, { expr = true })

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.lsp.config.ts_ls  = {
  cmd = { "typescript-language-server", "--stdio" },
  root_markers = {
    "package.json",
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  }
}


vim.lsp.config.htmlls        = {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },

  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
}

vim.lsp.config.cssls         = {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss" },
  root_markers = { "package.json", ".git" },
  init_options = {
    provideFormatter = true,
  },
}

-- TailwindCss {{{
vim.lsp.config.tailwindcssls = {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "ejs",
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "astro",
    "vue",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    "package.json",
    "node_modules",
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        htmlangular = "html",
        templ = "html",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
}


vim.lsp.enable({ "lua_ls", "htmlls", "cssls", "tailwindcssls", "ts_ls" })

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
})

local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "󰌵",
}

local shorter_source_names = {
  ["Lua Diagnostics."] = "Lua",
  ["Lua Syntax Check."] = "Lua",
}

function diagnostic_format(diagnostic)
  return string.format(
    "%s %s (%s): %s",
    diagnostic_signs[diagnostic.severity],
    shorter_source_names[diagnostic.source] or diagnostic.source,
    diagnostic.code,
    diagnostic.message
  )
end

vim.diagnostic.config({
  signs = {
    text = diagnostic_signs,
  },
  virtual_lines = {
    current_line = true,
    format = diagnostic_format,
  },
  underline = true,
  severity_sort = true,
})
