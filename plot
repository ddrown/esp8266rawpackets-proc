#!/bin/sh

gnuplot <<EOF
set terminal png size 900,600
set output "data10.png"
set xlabel "Seconds (.241 sender)"
set ylabel "microseconds"                            
set title "Clock Offsets after average difference removed"  
set key bottom left box
plot \
 "data-10-241-213" using 7:(\$7-\$6+1.924400-\$7*0.000007877)*1000000 title ".213",\
 "data-10-241-169" using 7:(\$7-\$6-13.5543-\$7*0.000011473)*1000000 title ".169",\
 "data-10-241-147" using 7:(\$7-\$6-20.38905-\$7*0.000002218)*1000000 title ".147",\
 "data-10-241-179" using 7:((\$7-\$6-22.48006-\$7*0.000000316)*1000000) title ".179"
EOF

for i in data-10-241-179 data-10-241-147 data-10-241-169 data-10-241-213; do
  ./linear-fit <$i >$i.lin
done
gnuplot <<EOF
set terminal png size 900,600
set output "data10-ppm.png"
set xlabel "Seconds (.241 sender)"
set title "Clock Frequencies - linear fit"
set ylabel "ppm"                            
set key bottom left box
plot \
 "data-10-241-213.lin" using 1:(1-\$3)*1000000 title ".213" ,\
 "data-10-241-169.lin" using 1:(1-\$3)*1000000 title ".169" ,\
 "data-10-241-147.lin" using 1:(1-\$3)*1000000 title ".147" ,\
 "data-10-241-179.lin" using 1:(1-\$3)*1000000 title ".179"
EOF

for i in 179 147 169 213; do
  ./apply-fit data-10-241-$i >data-10-241-$i.apply

  TWONINE=`./percentile 2 99 <data-10-241-$i.apply | ./mul 1000000000`
  ONE=`./percentile 2 1 <data-10-241-$i.apply | ./mul 1000000000`
  SFIVE=`./percentile 2 75 <data-10-241-$i.apply | ./mul 1000000000`
  TFIVE=`./percentile 2 25 <data-10-241-$i.apply | ./mul 1000000000`

  gnuplot <<EOF
set terminal png size 900,600
set output "data10-$i.png"
set xlabel "Seconds (.241 sender)"
set ylabel "nanoseconds"
set title "Clock Offsets after D term removed (32 sample per D term calc)"  
set key top left box
set label 1 gprintf("99%% = $TWONINE ns",99) at graph 0.01,0.3 left front
set label 2 gprintf("75%% = $SFIVE ns",95) at graph 0.01,0.25 left front
set label 3 gprintf("25%% = $TFIVE ns",5) at graph 0.01,0.2 left front
set label 4 gprintf(" 1%% = $ONE ns",1) at graph 0.01,0.15 left front
plot \
 "data-10-241-$i.apply" using 1:(\$3*1000000000) title ".$i recv", \
 $TWONINE title "99th percentile", \
 $SFIVE title "75th percentile", \
 $TFIVE title "25th percentile", \
 $ONE title "1st percentile"
EOF
done