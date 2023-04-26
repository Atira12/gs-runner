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
   map <C-_> :AC<Enter>
   xnoremap <C-_> :AMC<Enter>
```
