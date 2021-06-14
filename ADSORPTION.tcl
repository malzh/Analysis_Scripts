# Code by: Mar Alcaraz Hurtado
# June 2021
# Tcl Script, to be used with VMD 
##############################
# Description: this code computes the number of potassium in each of
# the coordination states of the potassium ions around O atoms.



###### PREDEFINED PROCEDURE: BIG DCD #######

proc bigdcd { script type args } {
    global bigdcd_frame bigdcd_proc bigdcd_firstframe vmd_frame bigdcd_running
  
    set bigdcd_running 1
    set bigdcd_frame 0
    set bigdcd_firstframe [molinfo top get numframes]
    set bigdcd_proc $script

    # backwards "compatibility". type flag is omitted.
    if {[file exists $type]} { 
        set args [linsert $args 0 $type] 
        set type auto
    }
  
    uplevel #0 trace variable vmd_frame w bigdcd_callback
    foreach dcd $args {
        if { $type == "auto" } {
            mol addfile $dcd waitfor 0
        } else {
            mol addfile $dcd type $type waitfor 0
        }
    }
    after idle bigdcd_wait
}

proc bigdcd_callback { tracedvar mol op } {
    global bigdcd_frame bigdcd_proc bigdcd_firstframe vmd_frame
    set msg {}
 
    # If we're out of frames, we're also done 
    # AK: (can this happen at all these days???). XXX
    set thisframe $vmd_frame($mol)
    if { $thisframe < $bigdcd_firstframe } {
        puts "end of frames"
        bigdcd_done
        return
    }
 
    incr bigdcd_frame
    if { [catch {uplevel #0 $bigdcd_proc $bigdcd_frame} msg] } { 
        puts stderr "bigdcd aborting at frame $bigdcd_frame\n$msg"
        bigdcd_done
        return
    }
    animate delete beg $thisframe end $thisframe $mol
    return $msg
}

proc bigdcd_done { } {
    global bigdcd_running
    
    if {$bigdcd_running > 0} then {
        uplevel #0 trace vdelete vmd_frame w bigdcd_callback
        puts "bigdcd_done"
        set bigdcd_running 0
    }
}

proc bigdcd_wait { } {
    global bigdcd_running bigdcd_frame
    while {$bigdcd_running > 0} {
        global bigdcd_oldframe
        set bigdcd_oldframe $bigdcd_frame
        # run global processing hooks (including loading of scheduled frames)
        display update ui
        # if we have read a new frame during then the two should be different.
        if { $bigdcd_oldframe == $bigdcd_frame } {bigdcd_done}
    }
}


######## PROCEDURE #########

# Define the variables that are goint to be in the output
proc adsorption { frame } {
  global sel1 sel2 sel3 sel4 sel5 sel6 fp
  puts "$frame"
  
  $sel1 frame $frame
  $sel1 update 
  
  $sel2 frame $frame
  $sel2 update 
  
  $sel3 frame $frame
  $sel3 update 
  
  $sel4 frame $frame
  $sel4 update 
  
  $sel5 frame $frame
  $sel5 update 
  
  $sel6 frame $frame
  $sel6 update 
  
  set n1 [$sel1 num] 
  set n2 [$sel2 num] 
  set n3 [$sel3 num] 
  
  set n4 [$sel4 num] 
  set n5 [$sel5 num] 
  set n6 [$sel6 num] 
  
  puts $fp "$frame $n1 $n2 $n3 $n4 $n5 $n6" 
  
}


# Defining the output file
set fp [ open "ads_bas_ap.dat" w ] 

# Open needed files for calculation in VMD
set mol [mol new ../../build/system.psf type psf waitfor all]

# Define the counting needed

#Ions at second+first shell z>0
set sel1 [atomselect $mol {name POT and z>0 and ((within 5.77 of (name O13 or name O14)) or (within 5.9 of (name O32 or name O22)) or (within 5.2 of (name O21 or name O31)) or (within 5.5 of (name O11 or name O12)))}]

#Ions at second+first shell z<0
set sel2 [atomselect $mol {name POT and z<0 and ((within 5.77 of (name O13 or name O14)) or (within 5.9 of (name O32 or name O22)) or (within 5.2 of (name O21 or name O31)) or (within 5.5 of (name O11 or name O12)))}]

#Ions at first lipid shell z>0
set sel3 [atomselect $mol {name POT and z>0 and ((within 3.34 of (name O13 or name O14)) or (within 3.6 of (name O32 or name O22)) or (within 3.7 of (name O21 or name O31)) or (within 3.4 of (name O11 or name O12)))}]

#Ions at first lipid shell z<0
set sel4 [atomselect $mol {name POT and z<0 and ((within 3.34 of (name O13 or name O14)) or (within 3.6 of (name O32 or name O22)) or (within 3.7 of (name O21 or name O31)) or (within 3.4 of (name O11 or name O12)))}]

#Free ions z>0
set sel5 [atomselect $mol {name POT and z>0 and not ((within 5.77 of (name O13 or name O14)) or (within 5.9 of (name O32 or name O22)) or (within 5.2 of (name O21 or name O31)) or (within 5.5 of (name O11 or name O12)))}]

#Free ions z<0
set sel6 [atomselect $mol {name POT and z<0 and not ((within 5.77 of (name O13 or name O14)) or (within 5.9 of (name O32 or name O22)) or (within 5.2 of (name O21 or name O31)) or (within 5.5 of (name O11 or name O12)))}]


#Define which dcd are needed to perform the calculation in BIG DCD
puts "Please wait. Calculating..."
bigdcd adsorption auto ../s2_NVT_fieldon.dcd ../s3_NVT_fieldon.dcd
bigdcd_wait

#Close Output File         
close $fp 

exit
