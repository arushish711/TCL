proc get_cells_from_lib {file_name} {
    set fp  [open $file_name r]
    set cells {}
    while {[get $fp line] >= 0}
 {
    if {[regexp {^\s*cell\s*\(([^)]+)\)} $line -> cellname]} {
        lappend $cells cellname
    }
    
}   
close $fp
return $cells
}

##Build dict instead of lsearch

proc list_to_dirct {cell_list} {
    
    
    set d [dict create]
    foreach c $cell_list {
        dict set d $c 1
    }
    
    return $d
}

proc compare_lib_cells {libs1 libs2} {
    
    set cells1 [get_cells_from_lib $libs1]
    set cells2 [get_cells_from_lib $libs2]
    
    #Converting list to dict, reduces serach time to O(1)
    set dict1 [list_to_dict $cells1]
    set dict2 [list_to_dict $cells2]
    
    foreach c $cells1 {
        if {![dict exists $dict2 $c]} {
            puts $c
        }
    }
    
    forech c2 $cells2 {
        if {![dict exists $dict1 $c2]} {
            puts $c2
        }
    }
    
    
    
}
