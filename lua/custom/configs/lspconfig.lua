local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local u = require("custom.util")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "clojure_lsp", "svelte"}

local target_servers = {}
u.tableConcat(target_servers, servers)
u.tableConcat(target_servers, require('mason-lspconfig').get_installed_servers())
target_servers = u.unique(target_servers)

for _, lsp in ipairs(target_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
