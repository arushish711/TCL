set rpt {
  Design: cpu_top
  Mode: func
  Corner: ss_0p72v_125c
  
  WNS : -0.153
  TNS: -12.430
  NVP: 87
}

set wns ""
set tns ""
set nvp ""

foreach line [split $rpt "\n"] {
  if {[regexp {WNS\s*:\s*([-0-9.]+)} $line -> val]} {
    set wns $val
  }
  if {[regexp {TNS\s*:\s*([-0-9.]+)} $line -> val]} {
    set tns $val
  }
  if {[regexp {NVP\s*:\s*(\d+)} $line -> val]} {
    set nvp $val
  }
}

puts "WNS=$wns TNS=$tns NVP=$nvp"