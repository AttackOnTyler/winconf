# winconf

## Setup and Installation guide

This should get through every step of installing the entire modern dev experience for a given windows workstation, without admin privileges. Most companies have locked down changing any of those settings and thus this set up suite is complete for the sake of going 0 to 100 real quick.

This guide will cover the following...
- [Installing Chocolatey](#Install-Chocolatey)
- [Installing Neovim](#Install-Neovim)
- [Installing Git For Windows](#Install-GitForWindows)
- [Installing Oh-my-posh](#Install-ohmyposh)
- [Installing Noeriats (optional)](#Installing-noeriats)
- [Configuring Neovim](#Configuring-Neovim)
- [Installing GlazeWM](#Install-GlazeWM)

## Install Chocolatey

With the express purpose of installing Neovim to our desktop, we need some kind of windows package manager... and would you look at that. [Chocolatey](https://docs.chocolatey.org/en-us/choco/setup#non-administrative-install) is a windows package manager that can install for the local user, nice.

### Install Steps

- Open PowerShell.exe
- Run the following: Set-ExecutionPolicy Bypass -Scope Process -Force;
- Run .\ChocolateyInstallNonAdmin.ps1

You should now have the chocolatey package mananger installed in the C:\ProgramData dir

## Install Neovim

Now that we have a package manager on the low low, we can user install Neovim for use as our text editor of choice. We'll circle back to customizing it after we setup a few more things but we need to install it for the git-for-windows install.

### Install Steps

- Open PowerShell.exe
- Run the following: choco install neovim -y
- there is an optional install that doesn't need to be install in order for the core to work as is
- Add nvim to local path
    - Goto start -> 'env' -> 'Edit environment variables for your account'
    - Select 'Path' -> Edit
    - If you don't see '*neovim*' anywhere -> click 'New' -> 'Browse' -> Navigate to C:\tools\neovim\nvim-win64\bin

Neovim has now been installed and in any terminal, you should be able to run 'nvim .' to access netrw. Don't forget how to exit VIM!

## Install GitForWindows

Having gone through some command installation, we get a gui to work with! [GitForWindows](https://gitforwindows.org/) installs Git BASH and git commands as our shell and in our terminal/shell. BASH is more customizable that cmd or powershell and until my main place of employement upgrades to Win11 which should come with the new windows terminal by default and should allow us to install other shell environments like zsh. BASH is plenty good for now though as we'll be in NVIM land most of the time anyway!

### Install steps

- Navigate to the link above and click 'Download' from the main page
- Run the executable and when prompted about a default editor, select browse and navigate to the neovim/bin dir and select nvim.exe
- Test the sh and follow the instructions to exit nvim
- If previously installed gitforwindows, run the command git update-git-for-windows

Now that we have our editor and shell installed, we can start to customize our experience so we have what we need from a terminal and not anything extra.

## Install ohmyposh

Let's admit it. The default experience of BASH can leave a lot to be desired. The color choices, the text being broken onto 2 lines. It all being in a thin font-type that can make it hard to see. [ohmyposh](https://ohmyposh.dev/docs/installation/windows) allows user configuration of the default BASH experience. It just like everything else we've got running so far, user profile only, no admin priv.

### Install steps

- Open PowerShell.exe
- Run the following: Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('hyyp://ohmyposh.dev/install.ps1'))
- Install a nerdfont: current font [Intel One Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/IntelOneMono.zip)
    - Extract the files from csv, select the .ttf files, right-click and install
    - Files are included in the NerdFont folder in the repo
- Configure your terminal/editor to use the installed font
    - Right-click the title bar of a given shell -> Properties -> Font -> Font -> IntoneMono NFM*
- Configure your shell to use ohmyposh
    - copy the .bashrc from the ./Users/profile dir and add it to your local userprofile root (the one with docs, downs, pics...)
- Configure a theme for the Shell
    - copy the 'attackontyler.omp.json' from the ./Users/profile/.AppData/Local/nvim/theme dir and add it to the cooresponding folder in the $HOME dir (local userprofile root)
    - if a nvim folder doesn't yet exist, then create the directory structure for the theme to be added to

We should now have everything installed and our shell should be completely configured and themed. If currently in an existing BASH session, run the command exec bash to refresh the current bash profile.

## Installing noeriats

Noeriats is a custom language pack setting for English that maps the keyboard keys into the noeriats layout. The noeriats layout was generated via corpus and manual tuning to get the sweet spot of rolls, popular bi/trigram on separate fingers, improved home row, as well as symbol remapping for common symbols that get used more than 'q' for instance. I've been using this layout for 10 months and the number row and it's symbols have never been incorperated into my brain the same way and I'm typing aroung 80 wpm. The main reason to install a windows language pack rather than modifiying the layout manually, through keyboard settings, are shortcut keys do not get remapped in the layout when using noeriats through lang pack.

## Configuring Neovim

If adding ohmyposh, there should be an existing 'nvim' folder in the %localappdata% folder. If not, navigate to the %localappdata% folder and create a new nvim dir. This is where we will apply our user config, settings, install packages...

### Config steps

- add init.lua by % init.lua
    - add require("attackontyler") || whatever name your config folder will be in the lua dir we're about to make
    - <C-c>, save and quit to netrw with :w :Ex
- add a lua folder in the nvim dir with the command d
    - add the folder name that you were requiring in the init.lua we just created
- in the folder add another init.lua file
    - add require("attackontyler.remap") which will be the next file that we add so we can get some speed
    - add require("attackontyler.lazy") which will be our package manager for this nvimrc
    - add require("attackontyler.after.plugins") which will handle the plugins that are installed by lazy after install
- add another file remap.lua and add the following...
    - vim.g.mapleader = " "
    - vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    - 
    - -- The following remapping is mainly due to noeriats layout, also inverted 'T', because hjkl sucks, fight me
    - vim.keymap.set("n", "k", "a", { noremap = true })
    - vim.keymap.set("n", "j", "t", { noremap = true })
    - vim.keymap.set("n", "h", "i", { noremap = true })
    - vim.keymap.set("n", "l", "u", { noremap = true })
    - vim.keymap.set("n", "a", "j", { noremap = true })
    - vim.keymap.set("n", "u", "k", { noremap = true })
    - vim.keymap.set("n", "i", "h", { noremap = true })
    - vim.keymap.set("n", "t", "l", { noremap = true })
    - 
    - -- The following remapping is mainly due to noeriats, just for netrw
    - vim.api.nvim_create_autocmd('filetype', {
    -   pattern = 'netrw',
    -   desc = 'Better mappings for netrw',
    -   callback = function()
    -     local bind = function(lhs, rhs)
    -       vim.keymap.set('n', lhs, rhs, {remap = false, buffer = true})
    -     end
    - 
    -     -- move up
    -     bind('u', 'k')
    - 
    -     -- move down
    -     bind('a', 'j')
    -   end
    - })
- add another file lazy.lua and add the following...
    - local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    - if not vim.loop.fs_stat(lazypath) then
    -   vim.fn.system({
    -     "git",
    -     "clone",
    -     "--filter=blob:none",
    -     "https://github.com/folke/lazy.nvim.git",
    -     "--branch=stable", -- latest stable release
    -     lazypath,
    -   })
    - end
    - vim.opt.rtp:prepend(lazypath)
    - 
    - require("lazy").setup("attackontyler.plugins")
- add 'plugins' dir using 'd' in netrw
    - add 'onedark.lua'
        - return {
        -   "navarasu/onedark.nvim",
        -   priority = 1000,
        -   config = function()
        -     vim.cmd([[colorscheme onedark]])
        -   end
        - }
    - add 'telescope.lua'
        - return {
        -   'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -   dependencies = { 'nvim-lua/plenary.nvim' }
        - }
    - add 'vimbetter.lua'
        - return {
        -   'ThePrimeagen/vim-be-good'
        - }
- add 'after/plugins' dir
    - add 'init.lua'
        - require("attackontyler.after.plugins.colors")
        - require("attackontyler.after.plugins.telescope")
    - add 'colors.lua'
        - require('onedark').setup {
        -   -- Main options --
        -   style = 'deep',
        -   transparent = true,
        -   term_colors = false,
        -   ending_tildes = false,
        -   cmp_itemkind_reverse = false,
        - 
        -   -- toggle theme style --
        -   toggle_style_key = nil,
        -   toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'},
        - 
        -   -- Change code style --
        -   code_style = {
        -     comments = 'italic',
        -     keywords = 'none',
        -     functions = 'none',
        -     strings = 'none',
        -     variables = 'none'
        -   },
        - 
        -   -- Lualine options --
        -   lualine = {
        -     transparent = false,
        -   },
        - 
        -   -- Custom Highlights --
        -   colors = {},
        -   highlights = {},
        - 
        -   -- Plugins Config --
        -   diagnostics = {
        -     darker = true,
        -     undercurl = true,
        -     background = true,
        -   },
        - }
        - require('onedark').load()
    - add 'telescope.lua'
        - local builtin = require('telescope.builtin')
        - vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        - vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        - vim.keymap.set('n', '<leader>ps', function()
        -   builtin.grep_string({ search = vim.fn.input("Grep > ") });
        - end)
- There is still more to setup within nvim, i just haven't done it yet.
    - We still need [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
        - And its after/plugins/treesitter.lua
    - We still need Treesitter/[playground](https://github.com/nvim-treesitter/playground)\
    - We still need [harpoon](https://github.com/theprimeagen/harpoon)
        - and its after/plugins/harpoon.lua
    - We still need [undotree](https://github.com/mbbill/undotree)
        - and its after/plugins/undotree.lua
    - We need [vim-fugitive](https://github.com/tpope/vim-fugitive)
        - and its after/plugins/fugitive.lua
    - We still need an [LSP](http://github.com/vonHeikemen/lzp-zero.nvim)
        - and its after/plugins/lsp.lua
    - We still need to create our sets for lnums, rlnums, tabs to be at a normal width
        - this should be included in the ./attackontyler/init.lua at the top of the file
    - We still need to add to the remap.lua, we just got a little default config in place, so we can more easily navigate while setting every thing up initially

## Install GlazeWM

Windows is windows and while that's good and all... I'd rather have a tiling window manager that operates off workspaces. GlazeWM requires no auth priv and is super configurable. The ./Users/profile/.glaze-wm dir can be copied to the appropriate user dir for a quick set up in noeriats for 2 monitors. Going to 3 can be changed in the 'workspaces:' section. The workspaces are defined for use with the noeriats lang pack where the display_names of workspaces are changed to match the layout and the actual value of an (ctrl or alt) w|w/o shift changes to the standard shortcuts of the default qwerty layout. If on a firmware modified keyboard to have noeriats bound to the physical key press, then this config file will need to be updated to reflect the physical shortcut being pressed as is.

