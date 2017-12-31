document.write('\
\
<h2 id="example_1">Example 1</h2>\
<br>\
<p>\
The following code creates a new map with 3 key/item pairs, where the keys are dates \
and the items are packed decimals.\
</p>\
<pre class="pcode">\
map = rm_m(<br>\
  rm_d(d\'2017-01-01\') : rm_p(100.50) :<br>\
  rm_d(d\'2017-05-01\') : rm_p(50)     :<br>\
  rm_d(d\'2017-07-02\') : rm_p(201.10) );<br>\
</pre>\
<p>\
An alternative way of creating the same map would be as follows.\
</p>\
<pre class="pcode">\
map = rm_insert(rm_m() :<br>\
  rm_d(d\'2017-01-01\') : rm_p(100.50) :<br>\
  rm_d(d\'2017-05-01\') : rm_p(50)     :<br>\
  rm_d(d\'2017-07-02\') : rm_p(201.10) );<br>\
</pre>\
<p>\
Procedure <a href="#rm_m"><code>rm_m</code></a> creates a new map, which in this case is \
immediately populated. Procedure <a href="#rm_ins"><code>rm_insert</code></a> inserts the \
key/item pairs into the new map, and returns the new map that was passed as the first \
argument. Procedures that return their first argument, the map/value, can be used for \
"chaining" procedure calls.\
</p>\
<p>\
Procedures <a href="#rm_d"><code>rm_d</code></a> and <a href="#rm_p"><code>rm_p</code></a> \
create a new date value and a new packed decimal value, that are inserted into the map as a \
key and an item. Every supported data type has a <code>rm_??</code> procedure to create new \
values, where <code>??</code> is 1 or 2 characters that identify the type.\
</p>\
<p>\
RPG values are wrapped into RpgMap values using the <code>rm_??</code> procedures, \
so that RpgMap can handle values of different types uniformly. Later when these RPG values \
are needed they are unwrapped again using the <code>rm_??_</code> procedures, \
such as <a href="#rm_d_"><code>rm_d_</code></a> and <a href="#rm_p_"><code>rm_p_</code></a> \
(with trailing underscore).\
</p>\
<p>\
To retrieve the item with key 2017-05-01 one of the following statements can be used.\
</p>\
<pre class="pcode">\
x = rm_get(map: rm_d(d\'2017-05-01\') ); // uses only one key, \'*f\'/\'*l\'<br>\
x = rm__(  map: rm_d(d\'2017-05-01\') ); // may use mutiple keys<br>\
x = rm__d( map:      d\'2017-05-01\'  ); //  "    "    "      " without wrapping<br>\
</pre>\
<p>\
The date value arguments for procedures <a href="#rm_get"><code>rm_get</code></a> and \
<a href="#rm__"><code>rm__</code></a> will be automatically disposed (i.e. released, deallocated).\
</p>\
<p>\
Variable <code>x</code> is a pointer which now points to the RpgMap packed decimal value that \
was created with <a href="#rm_p"><code>rm_p</code></a> earlier, and which is still contained \
in the map. But we need a normal RPG packed decimal value. Expression <code>rm_p_(x)</code> \
converts the RpgMap packed decimal value <code>x</code> to a normal RPG packed decimal \
value.\
</p>\
<p>\
The following statement displays the sum of the items with keys 2017-05-01 and 2017-07-02.\
</p>\
<pre class="pcode">\
display(%char( rm_p_(rm__d(map:d\'2017-05-01\')) + rm_p_(rm__d(map:d\'2017-07-02\')) ));<br>\
</pre>\
<br>\
<pre class="console">\
DSPLY  251.1000<br>\
</pre>\
<p>\
When <code>map</code> is not needed anymore we need to dispose it with <a href="#rm_dis"><code>rm_dispose</code></a> \
to release/deallocate/free the memory it is using. This will also dispose all contained \
values, automatically disposed maps and associated cursors.\
</p>\
<pre class="pcode">\
rm_dispose(map);<br>\
</pre>\
\
');
