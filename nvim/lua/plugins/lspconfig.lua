return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		require("lspconfig").pylsp.setup({
			capabilities = capabilities
		})
		require("lspconfig").rust_analyzer.setup({
			capabilities = capabilities
		})
		require("lspconfig").eslint.setup({
			capabilities = capabilities
		})
		require("lspconfig").ts_ls.setup({
			capabilities = capabilities
		})
		require("lspconfig").yamlls.setup({
			capabilities = capabilities,
			settings = {
				yaml = {
					schemas = {
						["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] =
						"/*.k8s.yaml",
					},
				},
			}
		})
		require("lspconfig").tailwindcss.setup({
			capabilities = capabilities
		})
		require("lspconfig").lua_ls.setup({
			capabilities = capabilities
		})
		require("lspconfig").qmlls.setup({
			capabilities = capabilities
		})
	end,
}
