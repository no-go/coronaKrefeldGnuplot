#!/bin/bash

printf "\
set title filename1
#set terminal pdf linewidth 1 size 16cm,14cm
set terminal png size 800,600
set label \"Corona Situation\" at screen 0.47, 0.935 font \"Arial,9\"
set output outputFile
#set logscale y 2
set xlabel \"Tag\"
set ylabel \"Anzahl\"
# https://stackoverflow.com/questions/19412382/gnuplot-line-types
set colorsequence podo

set boxwidth 1.0 relative
set style fill solid 0.15 border 0.15

set key left top
set grid
set xdata time

delta_v(x) = ( vD = x - old_v, old_v = x, vD)
old_v = NaN

" > /tmp/$0.plot

echo "set timefmt \"%Y-%m-%d\"" >> /tmp/$0.plot
echo "set format x \"%d.%m.\"" >> /tmp/$0.plot

printf "\

set yrange[0:]
set xrange['2020-03-03':]

plot filename1 using 1:(delta_v(\$2))         with boxes        title 'Abstriche', \
     filename1 using 1:(\$3 == 0 ? NaN : \$3 -\$4 -\$7) with lines  lw 2  title 'zur Zeit krank', \
     filename1 using 1:(\$4 == 0 ? NaN : \$4) with points pt 9  title 'geheilt', \
     filename1 using 1:(\$5 == 0 ? NaN : \$5) with lines  lw 2  title 'stationär', \
     filename1 using 1:(\$6 == 0 ? NaN : \$6) with lines  lw 2  title 'intensiv', \
     filename1 using 1:(\$7 == 0 ? NaN : \$7) with points pt 11 title 'tot' \
      \
" >> /tmp/$0.plot

gnuplot -persist -e "outputFile='./$1_2.png';filename1='$1.txt'" /tmp/$0.plot
