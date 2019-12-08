document.write('\
\
<div id="rm_setgt_read_prev"><div class="prochdr1">rm_setgt_read_prev</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Set greater than, read previous</div></div>\
<pre class="procsig">\
&lt;&lt;ind<br>\
cur  pointer value<br>\
pos  ind           options(*nopass:*omit)<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Analogous to <a href="#rm_setll_read_next"><code>rm_setll_read_next</code></a>, this procedure combines <a href="#rm_setgt"><code>rm_setgt</code></a> and \
<a href="#rm_read_prev"><code>rm_read_prev</code></a> into one.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Each time <a href="#rm_setgt_read_prev"><code>rm_setgt_read_prev</code></a> is called: &#x2460; if <code>pos</code> is <code>*on</code> the cursor is \
positioned with <a href="#rm_setgt"><code>rm_setgt</code></a> on <code>key1</code>, &#x2461; <code>pos</code> is set to <code>*off</code>, &#x2462; \
<a href="#rm_read_prev"><code>rm_read_prev</code></a> is called with <code>key1</code> and <code>key2</code> to read the previous \
key/item pair, &#x2463; the result of calling <a href="#rm_read_prev"><code>rm_read_prev</code></a> is returned.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Parameter <code>key1</code> is passed as argument <code>key</code> to <a href="#rm_setgt"><code>rm_setgt</code></a> and <code>key1</code> \
and <code>key2</code> are passed to <a href="#rm_read_prev"><code>rm_read_prev</code></a>. See the docs for <a href="#rm_setgt"><code>rm_setgt</code></a> and \
<a href="#rm_read_prev"><code>rm_read_prev</code></a> on how optional parameters <code>key1</code> and <code>key2</code> are specified.<br>\
<span class="bullet1">&#9679;</span>&nbsp;The following code loops through all keys equal to <code>d\'2017-01-01\'</code>, \
but backwards.\
</p>\
<pre class="pcode">\
pos = *on;<br>\
dow rm_setgt_read_prev(cur:pos:rm_d(d\'2017-01-01\')); // \'pos\' is set to *off<br>\
  ... // set \'pos\' to *on to trigger \'rm_setgt\' again while looping<br>\
enddo;<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>pos</code> is not passed or is *OMITted then the procedure behaves as if \
<code>pos</code> would have been passed with value <code>*on</code>. This can be used to position \
the cursor and read the previous key/item pair in one call without having \
to provide an indicator field.<br>\
<span class="bullet1">&#9679;</span>&nbsp;This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');
