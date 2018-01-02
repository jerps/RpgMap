document.write('\
\
<div id="rm_slln"><div class="prochdr1">rm_slln</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Set lower limit, read next</div></div>\
<pre class="proclongnm">rm_setll_read_next</pre>\
<pre class="procsig">\
&lt;&lt;ind<br>\
cur  pointer value<br>\
pos  ind           options(*nopass:*omit)<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;This procedure combines <a href="#rm_sll"><code>rm_sll</code></a> and <a href="#rm_rdn"><code>rm_rdn</code></a> into one, so that \
one expression enables both positioning the cursor and repeatedly \
reading the next key/item pair. Positioning is only done when \
input/output parameter <code>pos</code> is <code>*on</code>, which is set to <code>*off</code> automatically \
when <a href="#rm_slln"><code>rm_slln</code></a> is called. This parameter should be <code>*on</code> the first time \
<a href="#rm_slln"><code>rm_slln</code></a> is called to trigger the positioning.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Each time <a href="#rm_slln"><code>rm_slln</code></a> is called: &#x2460; if <code>pos</code> is <code>*on</code> the cursor is \
positioned with <a href="#rm_sll"><code>rm_sll</code></a> on <code>key1</code>, &#x2461; <code>pos</code> is set to <code>*off</code>, &#x2462; \
<a href="#rm_rdn"><code>rm_rdn</code></a> is called with <code>key1</code> and <code>key2</code> to read the next key/item \
 pair, &#x2463; the result of calling <a href="#rm_rdn"><code>rm_rdn</code></a> is returned.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;When doing a read-equal (i.e. when specifying only <code>key1</code> for <a href="#rm_rdn"><code>rm_rdn</code></a> \
or <a href="#rm_rdp"><code>rm_rdp</code></a>), <code>key1</code> must be specified twice (<a href="#rm_sll"><code>rm_sll</code></a> and <a href="#rm_rdn"><code>rm_rdn</code></a>). \
Using this method, <code>key1</code> needs to be specified only once, but at the \
cost of the extra indicator which makes the code a little more complex.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Parameter <code>key1</code> is passed as argument <code>key</code> to <a href="#rm_sll"><code>rm_sll</code></a> and <code>key1</code> \
and <code>key2</code> are passed to <a href="#rm_rdn"><code>rm_rdn</code></a>. See the docs for <a href="#rm_sll"><code>rm_sll</code></a> and \
<a href="#rm_rdn"><code>rm_rdn</code></a> on how optional parameters <code>key1</code> and <code>key2</code> are specified.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;The following code loops through all keys equal to <code>d\'2017-01-01\'</code>.\
</p>\
<pre class="pcode">\
pos = *on;<br>\
dow rm_slln(cur:pos:rm_d(d\'2017-01-01\')); // \'pos\' is set to *off<br>\
  ... // set \'pos\' to *on to trigger \'rm_sll\' again while looping<br>\
enddo;<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;If <code>pos</code> is not passed or is *OMITted then the procedure behaves as if \
<code>pos</code> would have been passed with value <code>*on</code>. This can be used to position \
the cursor and read the next key/item pair in one call without having \
to provide an indicator field.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');
