# winconf

## Setup and Installation guide

This should get through every step of installing the entire modern dev experience for a given windows workstation, without admin privileges. Most companies have locked down changing any of those settings and thus this set up suite is complete for the sake of going 0 to 100 real quick.

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

