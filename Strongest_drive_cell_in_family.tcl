proc strongest_drive_cell {lib_file} {
  set fp [open $lib_file r]
  set cell_drive [dict create]

  while {[get $fp line] >= 0} {
    if {[regexp {^\s*cell\s*\((.*)_X(\d+)\s*\)} $line -> cell drive]} {
      if {![dict exists $cell_drive $cell]}
      {
        dict set cell_drive $cell $drive
      }
      else {
        set old_drive [dict get $cell_drive $cell]
        if ($old_drive < $drive) {
          dict set cell_drive $cell $drive
        }
      }
    }
  }
close $fp
dict for {cell drive} $cell_drive {
  puts "Strongest cells for $cell is ${cell}_X${drive}"
}
}
