proc count_arcs_per_output_pin {lib_file} {
  set fp [open $lib_file r]
  set current_cell ""
  set current_pin ""
  set arc_count [dict create]

  while {[gets $fp line] >= 0} {
      if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cellname]} {
          set current_cell $cellname
          continue
      }
      if {[regexp {^\s*pins\s*\(([^)])\)} $line -> pin]} {
          set current_pin $pin
          continue
      }
      if {$current_cell ne "" && $current_pin ne "" && [regexp {^\s*related_pin\s*:} $line]} {
          set key "${current_cell}/${current_pin}"
          if {[dict exists $arc_count $key]} {
              dict incr arc_count $key
          }
          else {
              dict set arc_count $key 1
          }
      }
  }
close $fp

dict for {k v} $arc_count {
    puts "$k -> $v"
}
}
