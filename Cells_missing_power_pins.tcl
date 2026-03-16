proc get_pins_for_all_cells {lib_file} {
  set fp [open $lib_file r]
  set cell_pin [dict create]
  set current_cell ""
  while {[get $fp line] >= 0} {
    if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cellname]} {
        set $current_cell $cellname
        dict set cell_pin $cellname {}
        continue
    }
    if {[regexp {^\s*pin\s*\(([^)]+)\)} $line -> pin]} {
      if {$current_cell ne ""} {
        dict lappend cell_pin $current_cell $pin
      }
    }
  }
  close $fp
  return $cell_pin

}

proc check_pg_pin {lib_file} {
  set d [get_pins_for_all_cells $lib_file]
  dict for {cells pins} $d {
    if {[lsearch -exact $pins VDD] == -1 || [lsearch -exact $pins VCC] == -1} {
      puts "Missing PG Pins in $cells -> $pins"
    }
  }
}
