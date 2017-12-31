document.write('\
\
<div id="rm_rdn"><div class="prochdr1">rm_rdn</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Read next key/item pair</div></div>\
<pre class="proclongnm">rm_read_next</pre>\
<pre class="procsig">\
&lt;&lt;ind<br>\
cur  pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Call <a href="#rm_rdn"><code>rm_rdn</code></a> to read the next key/item pair for cursor <code>cur</code>, or \
call <a href="#rm_rdp"><code>rm_rdp</code></a> to read the previous key/item pair. The next/previous \
pair becomes the current key/item pair. Procedures <a href="#rm_key"><code>rm_key</code></a> and \
<a href="#rm_itm"><code>rm_itm</code></a> are used to read the current key or item, resp.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Return <code>*on</code> if there was a next or previous key/item. Return <code>*off</code> if \
the cursor is at the end or the beginning, in which case there is no current key/item anymore.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Key/item pairs can be removed while a cursor iterates over them. \
If the current key/item pair is removed from the map then there is no \
current key/item pair anymore, and <a href="#rm_key"><code>rm_key</code></a> and <a href="#rm_itm"><code>rm_itm</code></a> will return \
<code>*null</code>. If <a href="#rm_rdn"><code>rm_rdn</code></a> was used to read the current key/item the cursor is \
positioned just before the key/item pair that comes after the removed \
key/item. If <a href="#rm_rdp"><code>rm_rdp</code></a> was used the cursor is positioned just after the \
key/item pair that comes before the removed key/item. Procedures <a href="#rm_rdn"><code>rm_rdn</code></a> \
and <a href="#rm_rdp"><code>rm_rdp</code></a> must be used to get a current key/item pair again. The cursor \
is positioned at the end or beginning, resp., when there is no next or \
previous pair anymore.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If <code>key1</code> and/or <code>key2</code> are passed then the next or previous key must be \
equal to or greater than <code>key1</code>, and equal to or less than <code>key2</code>, else \
return <code>*off</code> (the cursor is at the end/beginning and there is no current \
key/item anymore). Both keys are optional. If <code>key1</code> is not passed or \
<code>*null</code> it\'s assumed to be the lowest key. If <code>key2</code> is not passed it\'s \
assumed to be the same as <code>key1</code> (if <code>key1</code> is passed). If <code>key2</code> is \
<code>*null</code> it\'s assumed to be the highest key. Always return <code>*off</code> if <code>key1</code> \
is greater than <code>key2</code>, or if only <code>key1</code> is passed with value <code>*null</code>.<br>\
<span class="bullet1">&#8226;</span>&nbsp;These procedures dispose <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');