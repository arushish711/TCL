set rpt {
  Startpoint: U1/CK
  Endpoint: U2/D
  slack (VIOLATED) -0.121
  
  Startpoint: U3/CK
  Endpoint: U4/D
  slack (VIOLATED) -0.342
  
  Startpoint: U5/CK
  Endpoint: U6/D
  slack (VIOLATED) 0.052
}

set worst_slack 999999

foreach line [split $rpt "\n"] {
  if {[regexp {slack\s+\(\S+\)\s+([-0-9.]+)} $line -> val]} {
    if {$val < $worst_slack} {
      set worst_slack $val
    }
  }
  
}

puts "worst_slack: $worst_slack"
