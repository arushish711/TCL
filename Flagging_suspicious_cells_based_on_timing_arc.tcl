proc counting_timing_arcs_per_cell {file_name} {
  set fp [open $file_name r]
  set current_cell ""
  set arc_counts [dict create]

  while { [get $fp line] >= 0 } {
      if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cell_name]} {
          set current_cell $cell_name

          #Initial count if first time seen
          if(![dict exists $arc_counts $current_cell]) {
            dict set arc_counts $current_cell 0
          }
      }

      if {$current_cell ne "" && [regexp {^\s*related_pin\s*:([^*]+)"} $line -> rpin]} {
        dict incr arc_counts $current_cell
      }
  
  }
close $fp
return $arc_counts
}

proc flag_suspicious_cells {lib_file} {
  set arc_counts [counting_timing_arcs_per_cell $lib_file]
  puts "Suspicious cells:"
  dict for {cell count} $arc_count {
    if {$count == 0} {
        puts "$cell -> No timing arc"
    }
    if {$count < 2} {
        puts "$cell -> Very few timing arcs: $count"
    }

  }

}
