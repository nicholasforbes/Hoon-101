|=  in=*                        ::Create gate accepting a noun
^-  tape                        ::Typecast to a tape (string) redundant but good style?
?^  in                          :: Check if in is of type cell
  "cell"                        :: If so cell will be out output
?:  =(0 (mod in 2))             :: is the input even? "even" is our output else "odd"
  "even"
"odd"