# Code by: Mar Alcaraz Hurtado
# June 2021
# Tcl Script, to be used with VMD 
##############################
# Description: this code computes the RDF of K+ ions
# around a certain O atom

#Import the files to VMD that are needed for the computation, psf and dcd.
puts "Reading data..."
mol new ../../build/system.psf type psf first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol addfile ../s1_NVT_fieldon.dcd type dcd first 0 last -1 step 2 filebonds 1 autobonds 1 waitfor all
mol addfile ../s2_NVT_fieldon.dcd type dcd first 0 last -1 step 10 filebonds 1 autobonds 1 waitfor all
mol addfile ../s3_NVT_fieldon.dcd type dcd first 0 last -1 step 10 filebonds 1 autobonds 1 waitfor all

#Get the number of frames in the dcd files.
puts "read $nf frames"
set nf [molinfo top get numframes]


#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O11"] #oxygen atom to put as center
set sel2 [atomselect top "name POT"] #type of atom to perform the RDF calculation

#Calculate RDF

puts "Calculating g(r) O11_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO11_POT.dat w]
set r [lindex $gr 0]
set grresult [lindex $gr 1]
set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile

######NEW OXYGEN ATOM################

#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O12"] #oxygen atom to put as center
set sel2 [atomselect top "name POT"] #type of atom to perform the RDF calculation

#Calculate RDF
puts "Calculating g(r) O12_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO12_POT.dat w]
set r [lindex $gr 0]
set grresult [lindex $gr 1]
set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile

######NEW OXYGEN ATOM################

#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O13"]
set sel2 [atomselect top "name POT"]

#Calculate RDF
puts "Calculating g(r) O13_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO13_POT.dat w]

set r [lindex $gr 0]
set grresult [lindex $gr 1]

set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile

######NEW OXYGEN ATOM################

#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O14"]
set sel2 [atomselect top "name POT"]

#Calculate RDF
puts "Calculating g(r) O14_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO14_POT.dat w]

set r [lindex $gr 0]
set grresult [lindex $gr 1]

set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile

######NEW OXYGEN ATOM################

#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O21"]
set sel2 [atomselect top "name POT"]

#Calculate RDF
puts "Calculating g(r) O21_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO21_POT.dat w]

set r [lindex $gr 0]
set grresult [lindex $gr 1]

set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile

######NEW OXYGEN ATOM################

#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O22"]
set sel2 [atomselect top "name POT"]

#Calculate RDF
puts "Calculating g(r) O22_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO22_POT.dat w]

set r [lindex $gr 0]
set grresult [lindex $gr 1]

set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile

######NEW OXYGEN ATOM################

#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O31"]
set sel2 [atomselect top "name POT"]

#Calculate RDF
puts "Calculating g(r) O31_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO31_POT.dat w]

set r [lindex $gr 0]
set grresult [lindex $gr 1]

set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile

######NEW OXYGEN ATOM################

#Selecting the concrete atoms which are needed for the computation
set sel1 [atomselect top "name O32"]
set sel2 [atomselect top "name POT"]

#Calculate RDF
puts "Calculating g(r) O32_POT. Please wait..."
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 1 first 1 last -1 step 1]

#Write data out
puts "Writing data to output file..."
set outfile [open gofrO32_POT.dat w]

set r [lindex $gr 0]
set grresult [lindex $gr 1]

set i 0
foreach j $r k $grresult {
 puts $outfile "$j $k"
}
close $outfile


exit
