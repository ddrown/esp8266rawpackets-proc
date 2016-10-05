This project is for https://github.com/cnlohr/esp8266rawpackets

Index:

data-10-241 - all data from the .241 sender, merged with the program "deltas"
 - columns: receiver ip, sender ip, recevier clock count, sender clock count, packet id, receiver clock seconds, sender clock seconds

data-10-241-147, data-10-241-169, data-10-241-179, data-10-241-213 - data-10-241 broken out by receiver

data-10-241-147.lin, data-10-241-169.lin, data-10-241-179.lin, data-10-241-213.lin - linear fit, 32 samples per row (program: "linear-fit")
 - columns: start sender clock seconds, start receiver clock seconds, clock slope, clock intercept, chisq fit

data-10-241-147.apply, data-10-241-169.apply, data-10-241-179.apply, data-10-241-213.apply - applied linear fit data (program: "apply-fit")
 - columns: sender clock seconds, predicted receiver clock seconds, actual-predicted difference, clock slope, clock intercept

plot - produce gnuplot graphs
