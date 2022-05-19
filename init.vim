call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'tanvirtin/monokai.nvim'
Plug 'tpope/vim-fugitive'
Plug 'rmagatti/auto-session'
" Plug 'airblade/vim-gitgutter'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'machakann/vim-highlightedyank'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'feline-nvim/feline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)window
" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'psliwka/vim-smoothie'
Plug 'phanviet/vim-monokai-pro'
Plug 't9md/vim-choosewin'
Plug 'majutsushi/tagbar'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'vim-test/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-git'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'folke/trouble.nvim'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'phaazon/hop.nvim'
Plug 'cwebster2/github-coauthors.nvim'
"Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/vim-jsx-improve'
call plug#end()

" cmp settings
set completeopt=menu,menuone,preview

" vim-test mappings
nmap <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "neovim"

" spaces not tabs
set expandtab
set shiftwidth=2 
set tabstop=2

" tagbar
nmap tb :TagbarToggle<CR>

" Choosewin
nmap  w  <Plug>(choosewin)

" Remap fzf to ctrl p
" nmap <C-P> :FZF<CR>
" let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""' 

" esc in insert & visual mode
inoremap kj <esc>
vnoremap kj <esc>
" esc in command mode
" Note: In command mode mappings to esc run the command for some odd
" historical vi compatibility reason. We use the alternate method of
" existing which is Ctrl-C
cnoremap kj <C-C>

let mapleader=","
" Always show line numbers
set number

" when using :vsplit put new window on right
set splitright

" format on save
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()


" color settings
syntax on
colorscheme monokai_pro
set termguicolors
set cursorline

" nerdtree commands
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeMirror<CR>:NERDTreeToggle<CR> 
nnoremap <C-f> :NERDTreeFind<CR>
" show hidden files
let NERDTreeShowHidden=1

" save easily

" vim-gitgutter
" reduce update delay
set updatetime=100

" easymotion
" nmap S <Plug>(easymotion-overwin-f)
" nmap s <Plug>(easymotion-bd-f)
" lowercase matches lower and upper case, upper case matches only upper
" let g:EasyMotion_smartcase = 1
nmap s :HopChar1<CR>
nmap S :HopChar2MW<CR>

" highlightedyank
let g:highlightedyank_highlight_duration = 300

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fa <cmd>lua require('telescope').extensions.githubcoauthors.coauthors()<CR> 

" bufferline
nnoremap <silent> b :BufferLinePick<CR>
nnoremap <silent> B :BufferLinePickClose<CR>

lua << EOF
-- LSP config
-- require'lspconfig'.solargraph.setup{}
require("nvim-lsp-installer").setup {}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph", "tailwindcss", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	on_attach = on_attach,
	flags = {
	  debounce_text_changes = 150,
	}
  }
end
-- fzf config telescope stuff
require('telescope').setup {
  defaults = {
    file_ignore_patters = {"%.git/.*"},

	  mappings = {
	    n = {
	      ['<c-x>'] = require('telescope.actions').delete_buffer
	    }
	  }
  },
  pickers = {
    find_files = {
      hidden = true
    },
    find_command = {
      "ag",
      "--ignore",
      ".git",
      "-g",
      ""
    }
  },
  extensions = {
    fzf = {
	
    },
    githubcoauthors = {}
  }
}
require('hop').setup()
require('telescope').load_extension('fzf')
require('telescope').load_extension('githubcoauthors')

-- feline
require('feline').setup()

require('gitsigns').setup()

require('bufferline').setup {
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
    diagnostics = "nvim_lsp"
  }
}

require("trouble").setup()
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['solargarph'].setup {
    capabilities = capabilities
  }
EOF

autocmd BufNewFile,BufRead *.tsx setlocal filetype=javascriptreact
