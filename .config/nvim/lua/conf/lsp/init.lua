vim.fn.sign_define(
    "LspDiagnosticsSignError",
    {texthl = "LspDiagnosticsSignError", text = ""}
)
-- , numhl = "LspDiagnosticsSignError"
vim.fn.sign_define(
    "LspDiagnosticsSignWarning",
    {texthl = "LspDiagnosticsSignWarning", text = ""}
)
-- , numhl = "LspDiagnosticsSignWarning"
vim.fn.sign_define(
    "LspDiagnosticsSignHint",
    {texthl = "LspDiagnosticsSignHint", text = ""}
)
-- , numhl = "LspDiagnosticsSignHint"
vim.fn.sign_define(
    "LspDiagnosticsSignInformation",
    {texthl = "LspDiagnosticsSignInformation", text = ""}
)
-- , numhl = "LspDiagnosticsSignInformation"

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            update_in_insert = false,
            underline = true,
            signs = true
        }
    )

vim.cmd[[
fun! SetDiagnosticAu()
  aug DiagnosticAu
    au!
    autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
  aug END
endfun
fun! ToggleDiagnosticsPreviewText()
  if !exists('#DiagnosticAu#CursorHold')
    call SetDiagnosticAu()
  else
    aug DiagnosticAu
      autocmd!
    aug END
  endif
endfun
call SetDiagnosticAu()
]]

require'conf.lsp.tsserver'
require'conf.lsp.vuels'
require'conf.lsp.sumneko'
require'conf.lsp.rust_analyzer'
require'conf.lsp.pyright'
require'conf.lsp.jsonls'
require'conf.lsp.bashls'
require'conf.lsp.yamlls'
require'conf.lsp.dockerls'
require'conf.lsp.html'
require'conf.lsp.clangd'
require'conf.lsp.efm'