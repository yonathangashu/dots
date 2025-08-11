return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000 , 
    config = function()
    require('gruvbox').setup({
        transparent_mode = true
    })
	vim.cmd("colorscheme gruvbox")
	vim.o.background = "dark" -- or "light" for light mode
    end
}
