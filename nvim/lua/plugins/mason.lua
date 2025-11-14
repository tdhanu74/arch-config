return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    opts = { ensure_installed = { "prettier" } },
    priority=1000,
    config = function()
        require("mason").setup()
    end,
}