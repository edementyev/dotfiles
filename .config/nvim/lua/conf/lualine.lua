local lsp = vim.lsp
local get_current_buf = vim.api.nvim_get_current_buf

local function is_lsp_attached()
  return next(lsp.buf_get_clients()) ~= nil
end

local function get_diagnostics_count(severity)
  if not is_lsp_attached() then return nil end

  local bufnr = get_current_buf()
  local active_clients = lsp.buf_get_clients(bufnr)
  local count = 0

  for _, client in pairs(active_clients) do
    count = count + lsp.diagnostic.get_count(bufnr, severity, client.id)
  end

  return count
end

-- local function lsp_client_names()
--   local clients = {}
--   local icon = ' '

--   for _, client in pairs(lsp.buf_get_clients()) do
--     clients[#clients+1] = icon .. client.name
--   end

--   return table.concat(clients, ' ')
-- end
local function lsp_attached()
  local count = 0
  for _, _ in pairs(lsp.buf_get_clients()) do
    count = count + 1
  end
  return count > 0 and '  '..count or ''
end

local function diagnostic_errors()
  local count = get_diagnostics_count('Error')
  return count ~= nil and ('  ') .. count or ''
end

local function diagnostic_warnings()
  local count = get_diagnostics_count('Warning')
  return count ~= nil and ('  ') .. count or ''
end

local function diagnostic_hints()
  local count = get_diagnostics_count('Hint')
  return count ~= nil and ('  ') .. count or ''
end

local function diagnostic_info()
  local count = get_diagnostics_count('Information')
  return count ~= nil and ('  ') .. count or ''
end

local function position()
    return string.format('%d/%d:%d', vim.fn.line('.'), vim.fn.line('$'), vim.fn.col('.'))
end

require'lualine'.setup{
  options = {
    theme = 'tokyonight',
    extensions = {'nvim-tree'},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {function () return diagnostic_errors()..diagnostic_warnings()..diagnostic_hints()..diagnostic_info()..lsp_attached() end},
    lualine_y = {'filetype', 'fileformat', 'encoding'},
    lualine_z = {position}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}