#!/usr/local/bin/zsh
# Attributed to Alp Kucukelbir <alp@cs.columbia.edu>.

gnuplot << EOF
set datafile separator ","
set terminal pdfcairo enhanced size 24cm,12cm font 'Helvetica,20'
set output '$1_time.pdf'

unset border
set grid
# set yrange [] reverse
# set logscale y
set key right bottom

# line styles for ColorBrewer Set3
# for use with qualitative/categorical data
# provides 8 hard-to-name colors
# compatible with gnuplot >=4.2
# author: Anna Schneider
# line styles
set style line 1 lc rgb '#66C2A5' # teal
set style line 2 lc rgb '#FC8D62' # orange
set style line 3 lc rgb '#8DA0CB' # lilac
set style line 4 lc rgb '#E78AC3' # magentat
set style line 5 lc rgb '#A6D854' # lime green
set style line 6 lc rgb '#FFD92F' # banana
set style line 7 lc rgb '#E5C494' # tan
set style line 8 lc rgb '#B3B3B3' # grey

# palette
set palette maxcolors 8
set palette defined ( 0 '#66C2A5', 1 '#FC8D62', 2 '#8DA0CB',\
                      3 '#E78AC3', 4 '#A6D854', 5 '#FFD92F',\
                      6 '#E5C494', 7 '#B3B3B3' )

set xlabel "Seconds"
set ylabel "ELBO"

# ls : line style from colorbrewer
# lw : line width
# pt : point type
# ps : point size
# pi : point interval (eg. -10 means every 10th datapoint)
plot "$1" using 2:(\$3) ls 1 lw 2 pt 7 ps 0.5 title "ADVI" with linespoints , \
EOF

open $1_time.pdf
