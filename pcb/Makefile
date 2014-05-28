# CAM processing
#   gerber(+drill) xy(+bom) png

cam:	
	pcb -x gerber --gerberfile layout --all-layers --copy-outline mask --name-style fixed board.pcb
	pcb -x bom --bomfile board.bom --xyfile board.xy board.pcb
	pcb -x png --outfile temp.png --dpi 1000 --photo-mode --photo-plating gold board.pcb
	<temp.png pngtopnm | pamscale 0.5 | pnmtopng >board.png
	rm -f temp.png
	pcb -x png --outfile temp.png --dpi 1000 --photo-mode --photo-flip-x --photo-plating gold board.pcb
	<temp.png pngtopnm | pamscale 0.5 | pnmtopng >board-reverse.png
	rm -f temp.png
	pcb -x ps --outfile board.ps board.pcb
	ps2pdf board.ps board.pdf
	rm -f board.ps

clean:
	rm -f *.gbr *.cnc *.png *.xy *.bom *~
	rm -f board.pcb.bak* board.pcb-
