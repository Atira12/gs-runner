# GhostScript Runner

### Vim plugin designed for simplifying PostScript/GhostScript

#### Commands

- GSComment - Comment a line
- GSRun - Run GhostScript interpreter for current file
- GSRunFile - Run GhostScript interpreter for specified file
- GSExport - Export Postscript file to wanted file type

#### Requirements

- Vim Plugin for highlighting & running PostScript (GhostScript)

#### Recommended mappings
```
   map <C-e> :GS({'vertical':1})<Enter>
   map <C-_> :GSC()<Enter>
```
#### Overrides
```
  let g:interpreter = '<custom-interpreter>'
  let g:interpreterParameters = '-dNOSAFER'
```
#### Install Plugin

- Vim-Plug

```
   Plug 'Atira12/gs-runner'
```
