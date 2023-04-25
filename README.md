
## Vim Plugin for executing PostScript(GhostScript) code
 <b style="color:red"> Commenting works for all files  </b>
 - Commands
   - VGS - Vertical Split GhostScript 
   - GS  - Horizontal Split GhostScript 
   - AC  - Single Line Commenting  
   - AMC  - Multiple Line Commenting  
 - Example Mappings
   ``
      map <C-e> :VGS<Enter>
      map <C-_> :AC<Enter>
      xnoremap <C-_> :AMC<Enter>
   ``
