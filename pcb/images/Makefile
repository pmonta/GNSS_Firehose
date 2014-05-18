logo.pcb: logo.svg
	inkscape logo.svg --export-pdf=logo.pdf
	pstoedit -xscale 0.75 -yscale 0.75 -psarg "-r1000x1000" -f pcbfill -ssp logo.pdf logo.pcb 2>/dev/null

oshw-logo.pcb: oshw-logo.svg
	inkscape oshw-logo.svg --export-pdf=oshw-logo.pdf
	pstoedit -xscale 0.16 -yscale 0.16 -psarg "-r1000x1000" -f pcbfill -ssp oshw-logo.pdf oshw-logo.pcb 2>/dev/null

text.pcb: text.svg
	inkscape text.svg --export-pdf=text.pdf
	pstoedit -xscale 0.4 -yscale 0.4 -psarg "-r1000x1000" -f pcbfill -ssp text.pdf text.pcb 2>/dev/null

clean:
	rm -f *~ *.pcb-
