proc get_cell_from_lib {lib_file} {
    
    set fb [open $lib_file r]
    set cells {}
    
    while {[gets $fp line] >= 0]} {
        
        if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cell_name]} {
            
            lappend cells $cell_name
        }
    }
    close $fp
    return $cells
    
}

proc compare_lib_cells {lib1 lib2} {
    
    set cells1 [get_cell_from_lib $lib1]
    set cells2 [get_cell_from_lib $lib2]
    
    puts "Cells present in $lib1 but not in $lib2:"
    foreach c $cells1 {
        if {[lsearch -exact $cells2 $c] == -1} {
            
            puts $c
        }
    }
    
    puts "Cells present in $lib2 but not in $lib1:"
    foreach c $cells2 {
        if {[lsearch -exact $cells1 $c] == -1} {
            puts $c
        }
        
    }
}
