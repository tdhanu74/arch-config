return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
	},
	config = function()
		require("cmp").setup({
			mapping = {
				['<Tab>'] = require("cmp").mapping.select_next_item({ behavior = require("cmp").SelectBehavior.Select }),
				['<S-Tab>'] = require("cmp").mapping.select_prev_item({ behavior = require("cmp").SelectBehavior.Select }),
				['<C-u>'] = require("cmp").mapping.scroll_docs(-4),
				['<C-d>'] = require("cmp").mapping.scroll_docs(4),
				['<C-Space>'] = require("cmp").mapping.complete(),
				['<C-y>'] = require("cmp").mapping.confirm({ select = true }),
				['<C-e>'] = require("cmp").mapping.abort(),
			},
			sources = {
				{ name = 'path' },
				{ name = 'nvim_lsp', keyword_length = 1 },
				{ name = 'buffer',   keyword_length = 3 },
			},
			formatting = {
				fields = { 'menu', 'abbr', 'kind' },
				format = function(entry, item)
					local menu_icon = {
						nvim_lsp = 'λ',
						buffer = 'Ω',
						path = '🖫',
					}
					item.menu = menu_icon[entry.source.name]
					return item
				end,
			},
		})
	end,
}

