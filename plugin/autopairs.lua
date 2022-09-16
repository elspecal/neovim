local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
  print "failed to load nvim-autopairs"
  return
end

autopairs.setup {
  enable_check_bracket_line = false,
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = { false }
  },
}

local Rule = require "nvim-autopairs.rule"
local ts_conds = require "nvim-autopairs.ts-conds"

autopairs.add_rules {
  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
}
