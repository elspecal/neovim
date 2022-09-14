local ok_luadev, luadev = pcall(require, "lua-dev")
if not ok_luadev then
  print "failed to load lua-dev"
end
luadev.setup {}

local ok_lspconf, lspconf = pcall(require, "lspconfig")
if not ok_lspconf then
  print "failed to start lsp configuraiton"
  return
end

local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then
  print "failed to load cmp"
  return
end

local ok_cmplsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not ok_cmplsp then
  print "failed to load cmp-lsp"
  return
end

local servers = {
  cssls = {},
  eslint = {},
  golangci_lint_ls = {},
  gopls = {},
  html = {},
  jsonls = {},
  prismals = {},
  pylsp = {},
  pyright = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        }
      }
    }
  },
  tsserver = {},
  yamlls = {},
}
local with_snippet_support = {
  cssls = true,
  html = true,
  jsonls = true,
}
local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local options = { capabilities = capabilities }

for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})

  if with_snippet_support[server] ~= nil then
    opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
  end
  if server == "tsserver" then
    local ok_ts, typescript = pcall(require, "typescript")
    if not ok_ts then
      print "failed to load the typescript plugin"
    else
      typescript.setup { server = opts }
    end
  else
    lspconf[server].setup(opts)
  end
end

local ok_luasnip, luasnip = pcall(require, "luasnip")
if not ok_luasnip then
  print "failed to load luasnip"
  return
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
}
