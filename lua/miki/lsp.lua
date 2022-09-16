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

local on_attach = function(client, _)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end
local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local options = {
  on_attach = on_attach,
  capabilities = capabilities,
}

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

require "luasnip.loaders.from_vscode".lazy_load()

local ok_lspkind, lspkind = pcall(require, "lspkind")
if not ok_lspkind then
  print "failed to load the lspkind plugin"
  return
end

local ok_autopairs, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not ok_autopairs then
  print "failed to load nvim-autopairs.completion.cmp"
else
  cmp.event:on("confirm_done", autopairs.on_confirm_done())
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
    ['<C-Space>'] = cmp.mapping.complete {},
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
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "cmdline" },
  },
  formatting = {
    format = lspkind.cmp_format { maxwidth = 50 },
  },
}
