document.write('\
\
<h2 id="example_2">Example 2</h2>\
<br>\
<p>\
The following map has composite keys, consisting of an integer and a date. The dates with \
key 5 have the "reversed order" property set (with <code>:0</code>).\
</p>\
<pre class="pcode">\
map = rm_m(<br>\
  rm_v( rm_i(1) : rm_d(d\'2017-01-01\'  ) ) : rm_p(100.50) :<br>\
  rm_v( rm_i(1) : rm_d(d\'2017-01-05\'  ) ) : rm_p(10)     :<br>\
  rm_v( rm_i(1) : rm_d(d\'2017-02-22\'  ) ) : rm_p(50)     :<br>\
  rm_v( rm_i(5) : rm_d(d\'2017-01-01\':0) ) : rm_p(15.9)   :<br>\
  rm_v( rm_i(5) : rm_d(d\'2017-02-02\':0) ) : rm_p(7.5)    :<br>\
  rm_v( rm_i(5) : rm_d(d\'2017-03-03\':0) ) : rm_p(80)     :<br>\
  rm_v( rm_i(7) : rm_d(d\'2017-05-01\'  ) ) : rm_p(100)    :<br>\
  rm_v( rm_i(7) : rm_d(d\'2017-06-02\'  ) ) : rm_p(1)      :<br>\
  rm_v( rm_i(7) : rm_d(d\'2017-07-03\'  ) ) : rm_p(5)      );<br>\
</pre>\
<p>\
A composite key is represented with a "vector" (see <a href="#vectors">Vectors</a>), which \
is a special kind of map, created with <a href="#rm_v"><code>rm_v</code></a>. The keys of a vector must \
be all integers and two vectors are compared in a special way. For example, vectors <code>rm_v(rm_i(1):rm_i(2))</code> \
and <code>rm_v(rm_i(1))</code> are considered to be equal. Only the items are specified for <a href="#rm_v"><code>rm_v</code></a>; \
the keys are implicitly created.\
</p>\
<p>\
Iteration is done through cursors, which must first be created with <a href="#rm_cur"><code>rm_cursor</code></a>. \
A cursor maintains a current position within the key/item pairs of a map. The position can be \
set using <a href="#rm_sll"><code>rm_setll</code></a> (set-lower-limit) or <a href="#rm_sgt"><code>rm_setgt</code></a> \
(set-greater-than). The next key/item pair can be read with <a href="#rm_rdn"><code>rm_read_next</code></a>. \
Procedures <a href="#rm_key"><code>rm_key</code></a> and <a href="#rm_itm"><code>rm_item</code></a> are \
used to retrieve the current key/item.\
</p>\
<p>\
The following code simply iterates through all key/item pairs and displays them.\
</p>\
<pre class="pcode">\
c = rm_setll(rm_cursor(map));<br>\
dow rm_read_next(c);<br>\
  display(       %char( rm_i_( rm__i(rm_key(c):1) ) ) +<br>\
          \'/\'  + %char( rm_d_( rm__i(rm_key(c):2) ) ) +<br>\
          \': \' + %char( rm_p_(      rm_item(c)    ) );<br>\
enddo;<br>\
</pre>\
<br>\
<pre class="console">\
DSPLY  1/2017-01-05: 10.0000<br>\
DSPLY  1/2017-02-01: 100.5000<br>\
DSPLY  1/2017-02-22: 50.0000<br>\
DSPLY  5/2017-03-03: 80.0000<br>\
DSPLY  5/2017-02-02: 7.5000<br>\
DSPLY  5/2017-01-01: 15.9000<br>\
DSPLY  7/2017-05-01: 100.0000<br>\
DSPLY  7/2017-06-01: 5.0000<br>\
DSPLY  7/2017-06-02: 1.0000<br>\
</pre>\
<p>\
The cursor should be disposed if it\'s not used anymmore.\
</p>\
<pre class="pcode">\
rm_dispose(c);<br>\
</pre>\
<p>\
The following code iterates through all key/item pairs with integer 5, displays each date, \
and the sum of the items.\
</p>\
<pre class="pcode">\
sum = 0;<br>\
c = rm_setll(rm_cursor(map):rm_v(rm_i(5)));<br>\
dow rm_read_next(c:rm_v(rm_i(5)));<br>\
  sum += rm_p_(rm_item(c));<br>\
  display(%char(rm_d_(rm__i(rm_key(c):2))));<br>\
enddo;<br>\
display(%char(sum));<br>\
</pre>\
<br>\
<pre class="console">\
DSPLY  2017-03-03<br>\
DSPLY  2017-02-02<br>\
DSPLY  2017-01-01<br>\
DSPLY  103.4000<br>\
</pre>\
<p>\
The keys that were passed as argument to <a href="#rm_sll"><code>rm_setll</code></a> and <a href="#rm_rdn"><code>rm_read_next</code></a>, \
<code>rm_v(rm_i(5))</code>, are automatically disposed.\
</p>\
<p>\
The map is disposed, and associated cursors are also disposed.\
</p>\
<pre class="pcode">\
rm_dispose(map);<br>\
</pre>\
\
');
