proc get_refs_from_netlist {netlist_file} {
  set fp [open $netlist_file r]
  set refs {}

  while {[gets $fp line] >= 0} {
    if {[regexp {^\s*(\S+)\s+(\S+)\s*\(} $line -> ref inst]} {
      lappend refs $ref
    }
  }
  close $fp
  return [lsort -unique $refs]
}

proc gets_cells_from_lib_file {lib_file} {
  set fp [open $lib_file r]
  set cells {}

  while {[gets $lib_file line] >= 0} {
    if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cell]}
    {
      lappend cells $cell
    }
  }
  close $fp
  return [lsort -unique $cells]
}

proc print_missing_lib_cells {netlist_file lib_file} {
  set nf [get_refs_from_netlist $netlist_file]
  set lf [gets_cells_from_lib_file $lib_file]

  set lib_dict [dict create]
  foreach c $lf {
    dict set lib_dict $c 1
  }
  foreach ref $nf {
    if {![dict exists $lib_dict $nf]} {
      puts "Used in netlist but missing in the lib: $ref"
    }
  }
}
