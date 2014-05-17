# CAM processing
#   gerber(+drill) xy(+bom) png

cam:	
	pcb -x gerber --gerberfile layout --all-layers --copy-outline mask --name-style fixed board.pcb
	pcb -x bom --bomfile board.bom --xyfile board.xy board.pcb
	pcb -x png --outfile board-large.png --dpi 1000 --photo-mode --photo-plating gold board.pcb
	<board-large.png pngtopnm | pamscale 0.5 | pnmtopng >board.png
	rm -f board-large.png

logo.pcb: logo.pdf
	pstoedit -psarg "-r1000x1000" -f pcbfill -ssp logo.pdf logo.pcb 2>/dev/null

clean:
	rm -f *.gbr *.cnc *.png *.xy *.bom
