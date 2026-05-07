require("config.lazy")

vim.keymap.set("n", "z", function()
  local query = vim.fn.input("⚡ ")
  if query ~= "" then
    vim.cmd("Zf " .. query)
  end
end, { desc = "jump to file" })

local function jumper_db()
  local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local dir = vim.fn.stdpath("data") .. "/jumper"
  vim.fn.mkdir(dir, "p")
  return dir .. "/" .. project .. ".jfiles"
end

-- set on startup
vim.env.__JUMPER_FILES = jumper_db()

-- update when cwd changes
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    vim.env.__JUMPER_FILES = jumper_db()
  end,
})
