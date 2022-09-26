local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
  print("failed to run mason")
  return
end

mason.setup({})
