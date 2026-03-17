proc get_pins_by_cell {lib_file} {
  set fp [open $lib_file r]
  set current_cell ""
  set d [dict create]

  while {[gets $fp line] >= 0} {
    if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cellname]} {
      set current_cell $cellname
      continue
    }
    if {[regexp {^\s*pins\s*(([^)]+)\)} $line -> pin]} {
      if {$current_cell ne ""} {
        dict lappend d $current_cell $pin
      }
    }
  }
close $fp
return $d
}

proc get_cells_from_lib {lib_file} {
  set fp [open $lib_file r]
  set cells {}

  while {[gets $fp line] >= 0} {
    if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cellname]} {
        lappend cells $cellname
    }
  }
  close $fp
  return [lsort -unique $cells]
}

proc write_lib_summary {lib_file out_file} {
  set cells [get_cells_from_lib $lib_file]
  set pins [get_pins_by_cell $lib_file]
  set fp [open $out_file w]

  puts $fp "Library Summary"
  puts $fp "Total Cells: [llength $cells]"
  puts $fp ""
  
  dict for {cell pin} $pins {
      puts $fp "$cell -> [llength $pin] pins"
  } 
}
