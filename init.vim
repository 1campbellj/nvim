call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'tanvirtin/monokai.nvim'
Plug 'tpope/vim-fugitive'
Plug 'rmagatti/auto-session'
" Plug 'airblade/vim-gitgutter'
"Plug 'williamboman/nvim-lsp-installer'
"Plug 'neovim/nvim-lspconfig'
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
"Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'vim-test/vim-test'
Plug 'vim-airline/vim-airline'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/cmp-git'
"Plug 'hrsh7th/nvim-cmp'
"Plug 'SirVer/ultisnips'
"Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'folke/trouble.nvim'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'phaazon/hop.nvim'
Plug 'cwebster2/github-coauthors.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'yuezk/vim-js'
call plug#end()

let g:vim_jsx_pretty_colorful_config = 1 " default 0
  
filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

" vim-test mappings
nmap <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "neovim"

" Ruby stuff
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

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
EOF


