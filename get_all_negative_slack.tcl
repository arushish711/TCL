proc get_negative_slacks {file_name} {
    set fp [open $file_name r]
    set slacks {}
    
    while {[gets $fp line] >= 0} {
        if {[regexp {slack.*?(-?\d+\.\d+)} $line -> slack]} {
            if {$slack < 0} {
                lappend slacks $slack
            }
        }
        
    }
    
    close $fp
    return $slacks
    
}

puts [get_negative_slacks "timing.rpt"]
