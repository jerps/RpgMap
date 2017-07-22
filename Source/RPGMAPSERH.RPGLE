**FREE

// RPGMAPSERH.RPGLE - RPGMAPSER header file 
// Copyright (c) 2017 John Erps      


/if defined(RPGMAPSER_H)
/eof
/else
/define RPGMAPSER_H
/endif


// Create new stream.
dcl-pr RMSerNewStream pointer;
  source pointer(*proc) value;
  sink pointer(*proc) value;
  minbuflen int(10) value;
end-pr;

// Write to a stream.
dcl-pr RMSerWriteStream;
  stream pointer value;
end-pr;

// Release a stream.
dcl-pr RMSerRlsStream;
  stream pointer value;
end-pr;

// Write bytes produced by a source to the stream buffer
dcl-pr RMSerWrtBufBytesFrmSrc;
  stream pointer value;
  bytes varchar(32000) const;
end-pr;

// Read bytes to be consumed by a sink from the stream buffer
// If reqnumbytes is positive then try to read the exact number of bytes and 
// return *on if the requested number of bytes has been read.
// If reqnumbytes is negative then read up to reqnumbytes bytes and return *on
// if >0 bytes have been read.
dcl-pr RMSerRdBufBytesForSnk ind;
  stream pointer value;
  bytes varchar(32000);
  reqnumbytes int(10) value;
end-pr;
