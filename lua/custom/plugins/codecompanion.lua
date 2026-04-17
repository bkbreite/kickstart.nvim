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
        interactions = {
          chat = {
            adapter = {
              name = 'copilot_acp',
              model = 'claude-opus-4.6',
            },
            roles = {
              user = 'Brandon',
            },
          },
        },
        rules = {
          default = {
            files = {
              '.clinerules',
              '.cursorrules',
              '.goosehints',
              '.rules',
              '.windsurfrules',
              '.github/copilot-instructions.md',
              'AGENT.md',
              'AGENTS.md',
              { path = 'CLAUDE.md', parser = 'claude' },
              { path = 'CLAUDE.local.md', parser = 'claude' },
              { path = '~/.claude/CLAUDE.md', parser = 'claude' },
              '~/.config/nvim/agents/codecompanion-context.md',
            },
            is_preset = true,
          },
        },
      }
    end,
  },
}
