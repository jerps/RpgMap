**FREE

// RPGMAPSER.RPGLE - RpgMap Serialization
// Copyright (c) 2017 John Erps        


ctl-opt copyright('Copyright (c) 2017 John Erps');
ctl-opt nomain ccsid(*exact);


/include RPGMAPGDEF.RPGLE
/include RPGMAPSERH.RPGLE


// ----- Data Structures

// buffer chunk
dcl-ds RMSerStreamChunk_t qualified inz template;
  num int(10);
  bytes pointer;
  nxt pointer;
end-ds;

// stream
dcl-ds RMSerStream_t qualified inz template;

  minbuflen int(10);    // min. buf length
  chunkf pointer;       // ptr to first RMSerStreamChunk_t
  chunkl pointer;       // ptr to last RMSerStreamChunk_t
  curpos int(10);       // current offset into buf of first RMSerStreamChunk_t
                        // 0 = first byte is next one to be read
  buflen int(10);       // number of bytes left to read
  eod ind;              // end of data?
  err ind;              // error?
  errmsg char(200);     // error message
  
  // the source fills the buffer
  // source signature:
  // rtn type : int(10)               // 0=ok; 1=eod; <0=error
  // par. 1   : stream pointer value  // this stream instance
  //      2   : usrd   pointer value  // user data
  source pointer(*proc);
  
  // the sink reads (consumes) the buffer
  // sink signature:
  // rtn type : int(10)               // 0=ok; 1=stop; <0=error
  // par. 1   : stream pointer value  // this stream instance
  //      2   : usrd   pointer value  // user data
  sink pointer(*proc);
  
end-ds;


// ----- Exported procedures


// Create a new stream.
dcl-proc RMSerNewStream export;
dcl-pi *n pointer;
  source pointer(*proc) value;
  sink pointer(*proc) value;
  minbuflen int(10) value;
end-pi;

  dcl-ds s likeds(RMSerStream_t) based(sp);

  sp = %alloc(%size(s));
  s.minbuflen = minbuflen;
  s.chunkf    = *null;
  s.chunkl    = *null;
  s.curpos    = 0;
  s.buflen    = 0;
  s.eod       = *off;
  s.err       = *off;
  s.errmsg    = '';
  s.source    = source;
  s.sink      = sink;        
  return sp;
  
end-proc;


// Release a stream.
dcl-proc RMSerRlsStream export;
dcl-pi *n;
  stream pointer value;
end-pi;

  dcl-ds s likeds(RMSerStream_t) based(sp);
  dcl-ds c likeds(RMSerStreamChunk_t) based(cp);
  dcl-s p pointer;

  sp = stream;
  cp = s.chunkf;
  dow cp <> *null;
    dealloc c.bytes;
    p = cp;
    cp = c.nxt;
    dealloc p;
  enddo;
  dealloc sp;

end-proc;


// Write bytes from a source to the stream buffer
dcl-proc RMSerWrtBufBytesFrmSrc export;
dcl-pi *n;
  stream pointer value;
  bytes varchar(32000) const;
end-pi;

  dcl-s b char(32000) based(bp);
  dcl-ds s likeds(RMSerStream_t) based(sp);
  dcl-ds c likeds(RMSerStreamChunk_t) based(cp);
  dcl-ds c2 likeds(RMSerStreamChunk_t) based(c2p);
  
  if %len(bytes) = 0;
    return;
  endif;
  bp = %alloc(%len(bytes));
  b = bytes;
  cp = %alloc(%size(c));
  c.num = %len(bytes);
  c.bytes = bp;
  c.nxt = *null;
  sp = stream;
  if s.chunkf = *null;
    s.chunkf = cp;
  endif;
  if s.chunkl <> *null;
    c2p = s.chunkl;
    c2.nxt = cp;
  endif;
  s.chunkl = cp;
  s.buflen += %len(bytes);

end-proc;


// Read bytes to be consumed by a sink from the stream buffer.
dcl-proc RMSerRdBufBytesForSnk export;
dcl-pi *n ind;
  stream pointer value;
  bytes varchar(32000);
  reqnumbytes int(10) value;
end-pi;

  dcl-s b char(32000) based(bp);
  dcl-ds s likeds(RMSerStream_t) based(sp);
  dcl-ds c likeds(RMSerStreamChunk_t) based(cp);
  dcl-s rnb int(10);
  dcl-s l int(10);

  bytes = '';
  
  if reqnumbytes = 0;
    return *on;
  endif;
  
  sp = stream;
  
  if     reqnumbytes > 0
     and s.buflen < reqnumbytes;
    return *off;
  endif;
  
  rnb = %abs(reqnumbytes);
  
  cp = s.chunkf;
  dow     s.buflen > 0
      and %len(bytes) < rnb;
    l = c.num - s.curpos;
    if l > rnb - %len(bytes);
      l = rnb - %len(bytes);
    endif;
    bp = c.bytes;
    bytes += %subst(b:s.curpos+1:l);
    s.curpos += l;
    s.buflen -= l;
    if s.curpos >= c.num;
      s.chunkf = c.nxt;
      dealloc c.bytes;
      dealloc cp;
      cp = s.chunkf;
      s.curpos = 0;
    endif;
  enddo;
  
  return *on;

end-proc;


// ----- Internal procedures
