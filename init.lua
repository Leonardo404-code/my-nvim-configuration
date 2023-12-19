require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Mapeia Ctrl + C para copiar a linha atual ou a área selecionada no modo visual
vim.api.nvim_set_keymap('n', '<C-c>', ':yank<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-c>', ':yank<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>:yank<CR>a', { noremap = true })

-- Mapeia Ctrl + V para colar
vim.api.nvim_set_keymap('n', '<C-v>', ':put<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>:put<CR>a', { noremap = true })

-- Mapeia Ctrl + X para recortar a linha atual no modo normal
vim.api.nvim_set_keymap('n', '<C-x>', ':delete<CR>', { noremap = true })

-- Mapeia Ctrl + X para recortar a área selecionada no modo visual
vim.api.nvim_set_keymap('v', '<C-x>', ':delete<CR>', { noremap = true })

-- Mapeia Ctrl + X para recortar a linha atual no modo de inserção
vim.api.nvim_set_keymap('i', '<C-x>', '<Esc>:delete<CR>a', { noremap = true })


vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)


local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
