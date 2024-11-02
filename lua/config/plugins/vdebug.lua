vim.cmd [[
  let g:vdebug_options = {}
  let g:vdebug_options["port"] = 9003
  let g:vdebug_options["ide_key"] = "nvim"
  let g:vdebug_options["path_maps"] = {
  \   "/app": resolve(finddir('.git/..', expand('%:p:h').';'))
  \ }
]]
