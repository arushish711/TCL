proc count_number_of_instances {verilog_netlist} {
  set fp [open $verilog_netlist r]
  set count [dict create]

  while {[get $fp line] >= 0} {
      if {[regexp {^\s*(\S+)\s+\S+\s*} $line -> cellname]} {
        if {![dict exists $count $cellname]} {
          dict set count $cellname 1
        }
        elseif {
          dict incr count $cellname
        }
      }
  }
  close $fp
  dict for {cell cnt} $count {
      puts "$cell -> $cnt"
  }
}
