return {
  {
    'oliveira/codecompanion.nvim',
    version = '^18.0.0',
    --opts = {
    --  strategies = {
    --    chat = {
    --      adapter = {
    --        name = 'copilot',
    --        model = 'claude-sonnet-4.6',
    --      },
    --      roles = {
    --        user = 'brandon',
    --      },
    --    },
    --  },
    --},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ttgrules/cc-adapter-copilot-cli-acp',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          acp = {
            copilot_cli = function() return require('codecompanion.adapters').extend('copilot_cli', {}) end,
          },
        },
        interactions = {
          chat = {
            adapter = 'copilot_cli',
            roles = {
              user = 'Brandon',
            },
          },
        },
      }
    end,
  },
}
