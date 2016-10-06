This project is for https://github.com/cnlohr/esp8266rawpackets

File index/Data flow:

 * all data from the .241 sender, merged with the program "deltas"
   * file: data-10-241
   * columns: receiver ip, sender ip, recevier clock count, sender clock count, packet id, receiver clock seconds, sender clock seconds
 * data-10-241 broken out by receiver
   * files: data-10-241-147, data-10-241-169, data-10-241-179, data-10-241-213
   * columns: same as data-10-241
 * linear fit, 32 samples per row (program: "linear-fit")
   * files: data-10-241-147.lin, data-10-241-169.lin, data-10-241-179.lin, data-10-241-213.lin
   * columns: start sender clock seconds, start receiver clock seconds, clock slope, clock intercept, chisq fit
 * applied linear fit data (program: "apply-fit")
   * files: data-10-241-147.apply, data-10-241-169.apply, data-10-241-179.apply, data-10-241-213.apply
   * columns: sender clock seconds, predicted receiver clock seconds, actual-predicted difference, clock slope, clock intercept
 * produced histogram of clock offsets from appled linear fit data (program: "histogram")
   * files: data-10-241-147.histogram, data-10-241-169.histogram, data-10-241-179.histogram, data-10-241-213.histogram
   * columns: nanosecond offset, sample count
 * produce gnuplot graphs
   * file: plot
