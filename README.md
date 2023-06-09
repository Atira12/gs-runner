### Vim plugin designed for simplifying PostScript/GhostScript

#### Commands

- GSC - Comment a line
- GS - Run GhostScript interpreter for current file
- FGS - Run GhostScript interpreter for specified file
- GSExport - Export Postscript file to wanted file type
- GSExport - Export Postscript file to wanted file type

#### Requirements

- GhostScript Interpreter

#### Recommended mappings

```
   map <C-e> :GS({'vertical':1})<Enter>
   map <C-_> :GSC()<Enter>
```

#### Install Plugin

- Vim-Plug

```
   Plug 'Atira12/gs-runner'
```
