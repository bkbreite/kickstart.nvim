-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
--
-- Place in your Neovim config (e.g., init.lua or a plugin file)
local function build_board_in_cros_sdk(opts)
  local board_name = opts.args or ''
  if board_name == '' then
    print 'No board name provided. Pass the board name as an argument to :BuildEC.'
    return
  end
  local cmd = string.format('bash -c "cd ~/google_tot/ && cros_sdk -- bash -c \'zmake build %s --clobber; exec bash\'"', board_name)
  vim.api.nvim_command('terminal ' .. cmd)
end

vim.api.nvim_create_user_command('BuildEC', build_board_in_cros_sdk, { nargs = 1 })

return {}
