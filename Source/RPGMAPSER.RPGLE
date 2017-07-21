**FREE

// RPGMAPSER.RPGLE - RpgMap Serialization
// Copyright (c) 2017 John Erps        


ctl-opt copyright('Copyright (c) 2017 John Erps');
ctl-opt nomain ccsid(*exact);


/include RPGMAPGDEF.RPGLE
/include RPGMAPSERH.RPGLE


// ----- Data Structures

dcl-ds RMSerStreamChunk qualified inz template;
  num int(10);
  bytes pointer;
  nxt pointer;
end-ds;

dcl-ds RMSerStream qualified inz template;

  minbuflen int(10);    // min. buf length
  chunkf pointer;       // ptr to first RMSerStreamChunk
  chunkl pointer;       // ptr to last RMSerStreamChunk
  curpos int(10);       // current offset into buf of first RMSerStreamChunk
                        // 0 = first byte is next one to be read
  buflen int(10);       // number of bytes left to read
  eod ind;              // end of data?
  
  // source signature
  // rtn type : int(10)               // 0=ok; 1=eod; <0=error
  // par. 1   : stream pointer value  // this stream instance
  //      2   : usrd   pointer value  // user data
  source pointer(*proc);
  
  // sink signature
  // rtn type : int(10)               // 0=ok; 1=stop; <0=error
  // par. 1   : stream pointer value  // this stream instance
  //      2   : usrd   pointer value  // user data
  sink pointer(*proc);
  
end-ds;


// ----- Exported procedures


// Create new read stream.
dcl-proc RMSerNewReadStream export;
dcl-pi *n pointer;
  minbuflen int(10) value;
  source pointer(*proc) value;
end-pi;

  dcl-ds s likeds(RMSerStream) based(sp);

  sp = %alloc(%size(s));
  s.minbuflen = minbuflen;
        
  return sp;
  
end-proc;


// ----- Internal procedures
