document.write('\
\
<div id="rm_hsn"><div class="prochdr1">rm_hsn</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Has next?</div></div>\
<pre class="proclongnm">rm_has_next</pre>\
<pre class="procsig">\
&lt;&lt;ind<br>\
cur  pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Return <code>*on</code> if cursor <code>cur</code> has a next or previous (<a href="#rm_hsn"><code>rm_hsn</code></a>/<a href="#rm_hsp"><code>rm_hsp</code></a>) \
key/item pair, i.e. whether <a href="#rm_rdn"><code>rm_rdn</code></a>/<a href="#rm_rdp"><code>rm_rdp</code></a> will return <code>*on</code> or not.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>key1</code> and/or <code>key2</code> are passed then the next or previous key must be \
equal to or greater than <code>key1</code>, and equal to or less than <code>key2</code>, else \
return <code>*off</code>. Both keys are optional. If <code>key1</code> is not passed or <code>*null</code> \
it\'s assumed to be the lowest key. If <code>key2</code> is not passed it\'s assumed \
to be the same as <code>key1</code> (if <code>key1</code> is passed). If <code>key2</code> is <code>*null</code> it\'s \
assumed to be the highest key. Always return <code>*off</code> if <code>key1</code> is greater \
than <code>key2</code>, or if only <code>key1</code> is passed with value <code>*null</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;These procedures dispose <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');
