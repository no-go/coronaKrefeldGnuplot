
all:
	#create krefeld.de.png from krefeld.de.txt
	sh plot.sh krefeld.de
	#create kreis-heinsberg.pdf from kreis-heinsberg.de.txt
	sh plot_heins.sh

clean:
	rm -rf *.png *.pdf
