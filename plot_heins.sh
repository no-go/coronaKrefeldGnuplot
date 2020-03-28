#!/bin/bash

printf "\
set title \"Kreis-Heinsberg.de\"
set label \"Corona Situation\" at screen 0.485, 0.94 font \"Arial,9\"
set terminal pdf linewidth 1 size 16cm,14cm
set output \"./kreis-heinsberg.pdf\"
set logscale y 2
set xlabel \"Tag\"
set ylabel \"Anzahl\"
set boxwidth 0.2
set style fill solid 0.25 border -1
set key left top
set grid
set xdata time
" > /tmp/$0.plot

echo "set timefmt \"%Y-%m-%d\"" >> /tmp/$0.plot
echo "set format x \"%d.%m.\"" >> /tmp/$0.plot

printf "\

set yrange[1:]
set xrange['2020-02-20':]

plot 'kreis-heinsberg.de.txt' using 1:2 with points pt 3  title 'Test positiv', \
     'kreis-heinsberg.de.txt' using 1:4 with points pt 9  title 'geheilt', \
     'kreis-heinsberg.de.txt' using 1:3 with points pt 11 title 'tot' \
" >> /tmp/$0.plot

gnuplot -persist /tmp/$0.plot
