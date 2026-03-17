proc cells_missing_output_pin {lib_file} {
  set fp [open $lib_file r]
  set missing_op_cells {}
  set current_cell ""
  set current_pin ""
  set has_output 0

  while {[get $fp line] >= 0} {
    if {[regexp {^\s*\cell\s*\(([^)]+)\)} $line -> cellname]} {
          if {$currrent_cell ne "" && !has_output} {
              lappend missing_op_cells $current_cell
          }
          set $current_cell $cellname
          set $has_output 0
          continue
    }
    if {[regexp {^\s*direction:\s*output\s*;} $line]} {
          set $has_ouput 1
    }
  }
  if {$current_cell ne "" && !$has_output} {
    lappend $missing_op_cells $current_cell
  }
  close $fp

  foreach c $missing_ap_cells {
      puts $c
  }
}
