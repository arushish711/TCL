set rpt {
  Startpoint: U1/CK
  Endpoint: U2/D
  slack (VIOLATED) -0.121
  
  Startpoint: U3/CK
  Endpoint: U4/D
  slack (VIOLATED) -0.342
  
  Startpoint: U5/CK
  Endpoint: U6/D
  slack (MET) 0.052
}
set count 0
foreach line [split $rpt "\n"] {
  if {[regexp {slack\s+\(VIOLATED\)} $line -> val]} {
      incr count
    }
  }

puts "Violating Paths: $count"
