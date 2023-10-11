local M = {}

M.abc = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>zx"] = {function() require("trouble").toggle() end, "Trouble: toogle"},
    ["<leader>zw"] = {function() require("trouble").toggle("workspace_diagnostics") end, "Trouble: Workspace diagnostics"},
    ["<leader>zd"] = {function() require("trouble").toggle("document_diagnostics") end, "Trouble: Document diagnostics"},
    ["<leader>zq"] = {function() require("trouble").toggle("quickfix") end, "Trouble: Quickfix"},
    ["<leader>zl"] = {function() require("trouble").toggle("loclist") end, "Trouble: loclist"},
    ["gR"] = {function() require("trouble").toggle("lsp_references") end, "Trouble: lsp_references"},
    -- ["<leader>mc"]
  },
}

-- more keybinds!

return M
