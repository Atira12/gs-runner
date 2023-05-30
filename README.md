### Vim plugin designed for simplifying PostScript/GhostScript 

#### Commands
 - AMC :  Add multiple line comment
 - AC : Add single line comment
 - GS - Run GhostScript interpreter for current file 
 - FGS - Run GhostScript interpreter for specified file


#### Requirements
  - GhostScript Interpreter

#### Recommended mappings
```
   map <C-e> :GS({'vertical':1})<Enter>
```
#### Recommended syntax highlighting
  1. Create a new folder .vim/syntax
  2. Move postscr.vim to the .vim/syntax folder
