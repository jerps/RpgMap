**FREE

// RPGMAPSERH.RPGLE - RPGMAPSER header file 
// Copyright (c) 2017 John Erps      


/if defined(RPGMAPSER_H)
/eof
/else
/define RPGMAPSER_H
/endif


// Create new read stream.
dcl-pr RMSerNewReadStream pointer;
  minbuflen int(10) value;
  source pointer(*proc) value;
end-pr;
