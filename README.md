# vim-ipython-ide
Plugin to work with iPython inside of VIM. You need VIM compiled with terminal support for this. 

This plugin allows you to send snippets of code to a terminal pane in VIM. By default it adds escape sequences to the code to make iPython accept it as one block (normally, a newline would trigger a return, very annoying if you want to paste, say, a for block). 

## Usage
First, you need to tell the plugin which buffer to send the code to. This is done by storing the buffer nr in the variable ```g:vide_main_buf```. The plugin provides to ways of setting this variable. Either run ```<leader>dc```, which creates a new terminal and sets it as the recipient termina. The second option is to execute ```<leader>dm``` in an exising terminal, which sets that terminal as the recipient. 

From that point you can send lines of code to the terminal by visually selecting it and pressing ```<leader>dp```. You can quickly move to the currently defined recipient terminal by pressing ```<leader>df```. 


