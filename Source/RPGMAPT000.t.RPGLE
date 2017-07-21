**FREE

ctl-opt main(Main) ccsid(*exact) bnddir('_TLIB_/RPGMAP');


/include _TLIB_/INCLUDERPG,RPGMAP


dcl-proc Main;

  dcl-s m pointer;
  dcl-s m2 pointer;
  dcl-s c pointer;
  dcl-s c2 pointer;
  dcl-s pos ind;
  dcl-s k pointer;
  dcl-s i pointer;
  dcl-s x int(10);
  dcl-s y int(10);
  dcl-s z int(10);
  dcl-s t varchar(500);
  dcl-s fd int(10);
  dcl-s path char(100);
  dcl-s buf char(1000);
  dcl-s word varchar(100);
  dcl-s ch char(1);
  dcl-s sum packed(30:4);
  
  m = rm_m(
    rm_v( rm_i(1) : rm_d(d'2017-02-01'  ) ) : rm_p(100.50) :
    rm_v( rm_i(1) : rm_d(d'2017-01-05'  ) ) : rm_p(10)     :
    rm_v( rm_i(1) : rm_d(d'2017-02-22'  ) ) : rm_p(50)     :
    rm_v( rm_i(5) : rm_d(d'2017-01-01':0) ) : rm_p(15.9)   :
    rm_v( rm_i(5) : rm_d(d'2017-02-02':0) ) : rm_p(7.5)    :
    rm_v( rm_i(5) : rm_d(d'2017-03-03':0) ) : rm_p(80)     :
    rm_v( rm_i(7) : rm_d(d'2017-05-01'  ) ) : rm_p(100)    :
    rm_v( rm_i(7) : rm_d(d'2017-06-02'  ) ) : rm_p(1)      :
    rm_v( rm_i(7) : rm_d(d'2017-06-01'  ) ) : rm_p(5)      );
  sum = 0;
  c = rm_sll(rm_cur(m):rm_v(rm_i(5)));
  dow rm_rdn(c:rm_v(rm_i(5)));
    sum += rm_p_(rm_itm(c));
    display(%char(rm_d_(rm__i(rm_key(c):2))));
  enddo;
  display(%char(sum));
  rm_dis(m);
end-proc;



dcl-proc display;
dcl-pi *n;
  text varchar(500) value;
end-pi;
  dcl-s t char(52);
  t = text;
  dsply t;
end-proc;
