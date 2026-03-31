return {
  {
    'olimorris/codecompanion.nvim',
    version = '^19.0.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          acp = {
            copilot_acp = function()
              return require('codecompanion.adapters').extend('copilot_acp', {
                commands = {
                  default = { 'copilot', '--acp', '--stdio', '--model', 'claude-opus-4.6' },
                },
              })
            end,
          },
        },
        interactions = {
          chat = {
            adapter = 'copilot_acp',
            roles = {
              user = 'Brandon',
            },
          },
        },
        opts = {
          system_prompt = function()
            local file = io.open(vim.fn.expand '~/.config/nvim/lua/custom/plugins/codecompanion-context.md', 'r')
            if file then
              local content = file:read '*a'
              file:close()
              return content
            end
            return ''
          end,
        },
      }
    end,
  },
}
