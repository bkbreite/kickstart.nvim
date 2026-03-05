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
            copilot_cli = function()
              return require('codecompanion.adapters').extend('copilot_cli', {
                handlers = {
                  form_messages = function(self, messages, capabilities)
                    local helpers = require 'codecompanion.adapters.acp.helpers'
                    local result = helpers.form_messages(self, messages, capabilities)
                    -- Prepend context file to first message of a new conversation
                    local already_sent = vim.iter(messages):any(function(m) return m._meta and m._meta.sent end)
                    if not already_sent and #result > 0 and result[1].type == 'text' then
                      local file = io.open(vim.fn.expand '~/.config/nvim/lua/custom/plugins/codecompanion-context.md', 'r')
                      if file then
                        local ctx = file:read '*a'
                        file:close()
                        result[1].text = ctx .. '\n\n' .. result[1].text
                      end
                    end
                    return result
                  end,
                },
              })
            end,
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
