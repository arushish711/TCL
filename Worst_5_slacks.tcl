proc top5_worst_slack {rpt_file} {
  set fp [open $rpt_file r]
  set slacks {}

  while {[gets $fp line] >= 0} {
    if {[regexp {^slack\s+\(\S+\)\s+(-?\d+.\d+)} $line -> slack]} {
        if {$slack < 0} {
          lappend slacks $slack
        }
    }
  }

  close $fp
  set sorted [lsort -real $slacks]
  set count [expr {llength $sorted} <5 ? [llength $sorted] : 5]

  for {set i 0} {$i < $count} {incr i} {
      puts [lindex $sorted $i]
  }
}
