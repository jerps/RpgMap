document.write('\
\
<div id="rm_sgtp"><div class="prochdr1">rm_sgtp</div><div class="prochdr2"> - Set greater than, read previous</div></div>\
<pre class="procsig">\
&lt;&lt;ind<br>\
cur  pointer value<br>\
pos  ind<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
Analogous to <a href="#rm_slln"><code>rm_slln</code></a>, this procedure combines <a href="#rm_sgt"><code>rm_sgt</code></a> and \
<a href="#rm_rdp"><code>rm_rdp</code></a> into one.<br>\
Each time <a href="#rm_sgtp"><code>rm_sgtp</code></a> is called: 1. if <code>pos</code> is <code>*on</code> the cursor is \
positioned with <a href="#rm_sgt"><code>rm_sgt</code></a> on <code>key1</code>; 2. <code>pos</code> is set to <code>*off</code>, 3. \
<a href="#rm_rdp"><code>rm_rdp</code></a> is called with <code>key1</code> and <code>key2</code> to read the previous \
key/item pair, 4. return the result of calling <a href="#rm_rdp"><code>rm_rdp</code></a>.<br>\
Parameter <code>key1</code> is passed as argument <code>key</code> to <a href="#rm_sgt"><code>rm_sgt</code></a> and <code>key1</code> \
and <code>key2</code> are passed to <a href="#rm_rdp"><code>rm_rdp</code></a>. See the docs for <a href="#rm_sgt"><code>rm_sgt</code></a> and \
<a href="#rm_rdp"><code>rm_rdp</code></a> on how optional parameters <code>key1</code> and <code>key2</code> are specified.<br>\
The following code loops through all keys equal to <code>d\'2017-01-01\'</code>, \
but backwards.\
</p>\
<pre class="pcode">\
pos = *on;<br>\
dow rm_sgtp(cur:pos:rm_d(d\'2017-01-01\')); // \'pos\' is set to *off<br>\
  ... // set \'pos\' to *on to trigger \'rm_sgt\' again while looping<br>\
enddo;<br>\
</pre>\
<p>\
This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');