proc print_cells_missing_function {lib_file} {
    set fp [open $lib_file r]
    set current_cell ""
    set has_function 0
    set missing_cells {}
    
    while {[gets $lib_file] >= 0} {
    
        #start a new cell
        if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cell_name]} {
            #Before moving to new cell, check previous cell
            if {$current_cell ne "" && !$has_function} {
                lappend missing_cells $current_cell
            }
            
            set current_cell $cell_name
            set has_function 0
            contiune
        }
        
        #Detect function line anywhere inside current cells
        if {$current_cell ne "" && [regexp {^\s*function\s*:} $line]} {
            set has_function 1
        }
            
        }
        
        #Check last cell after EOF
        if {$current_cell ne "" && !$has_function} {
            lappend missing_cells $current_cell
        }
        
        close $fp
        
        
        puts "Cells missing function:"
        foreach c $missing_cells {
            puts $c
        }
    }
}
