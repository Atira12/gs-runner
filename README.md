
## Vim Plugin for executing PostScript(GhostScript) code
 <b style="color:red"> Commenting works for all files  </b>
 - Commands
   - GS - Run GhostScript Terminal
   - AC  - Single Line Commenting  
   - AMC  - Multiple Line Commenting  
 - Example Mappings
   ``
      map <C-e> :GS({'vertical':1})<Enter>
      map <C-_> :AC<Enter>
      xnoremap <C-_> :AMC<Enter>
   ``
