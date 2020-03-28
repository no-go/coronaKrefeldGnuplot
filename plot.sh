#!/bin/bash

printf "\
set title filename1
#set terminal pdf linewidth 1 size 16cm,14cm
set terminal png
set label \"Corona Situation\" at screen 0.478, 0.9 font \"Arial,9\"
#set label \"Corona Situation\" at screen 0.485, 0.94 font \"Arial,9\"
set output outputFile
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

plot filename1 using 1:2 with points pt 3  title 'getestet', \
     filename1 using 1:3 with points pt 5  title 'positiv', \
     filename1 using 1:5 with points pt 1  title 'stationaer', \
     filename1 using 1:6 with points pt 12 title 'intensiv', \
     filename1 using 1:7 with points pt 11 title 'tot' \
" >> /tmp/$0.plot

#  filename1 using 1:4 with points pt 9  title 'geheilt', \

# gnuplot -persist -e "outputFile='./$1.pdf';filename1='$1.txt'" /tmp/$0.plot
gnuplot -persist -e "outputFile='./$1.png';filename1='$1.txt'" /tmp/$0.plot
