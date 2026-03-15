proc print_worst_violating_path {timing_report} {
  set fp [open $timing_report r]
  set startingpoint ""
  set endpoint ""
  set path_group ""

  #dict format
  #group -> {slack startpoint endpoint}
  set d [dict create]

  while {[get $fp line] >= 0} {
    if { [regexp {^\s*Startpoint:\s+(\S+)} $line -> sp]} {
        set startpoint $sp
        continue
    }

    if {[regexp {^\s*Endpoint:\s+(\S+)} $line -> ep]} {
        set endpoint $ep
        continue
    }
    if {[regexp {^\s*Path_group:\s+(\S+)} $line -> pg]} {
        set path_group $pg
        continue
    }

    if {[regexp {^\s*slack\s*\(S+\)\s*(-?\d+\.?\d+)} $line -> slack]} {
        if {$slack < 0} {
          if {![dict exists $d $path_group]} {
            dict set d $path_group [list $slack $startpoint $endpoint]
          }
          else {
            set old_data [dict get $d $path_group]
            set old_slack [lindex $old_data 0]

            if {$slack < $old_slack} {
                dict set d $path_group [dict $slack $startpoint $endpoint]
            
            }
          }
        }

      #Reset for next block path
      set startpoint ""
      set endpoint ""
      set path_group ""
      
    }
    }

    close $fp

    puts "Worst violating path per group"
    dict for {path_group data} $d {
      puts "Path_group: $path_group"
      puts "Slack: [lindex $data 0]"
      puts "Startpoint: [lindex $data 1]"
      puts "Endpoint: [lindex $data 2]"
    }
    }

}
