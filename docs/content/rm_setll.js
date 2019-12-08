document.write('\
\
<div id="rm_setll"><div class="prochdr1">rm_setll</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Set lower limit</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
cur pointer value<br>\
key pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Position cursor <code>cur</code> on <code>key</code> and return <code>cur</code>.<br> \
<span class="bullet1">&#9679;</span>&nbsp;Call <a href="#rm_setll"><code>rm_setll</code></a> to position the cursor just before the lowest key that is equal \
to or greater than <code>key</code>. Call <a href="#rm_setgt"><code>rm_setgt</code></a> to position the cursor just after the \
highest key that is equal to or less than <code>key</code>. If <code>key</code> is <code>*null</code> or not passed \
then the cursor is positioned at the beginning or the end, resp.<br>\
<span class="bullet1">&#9679;</span>&nbsp;After calling one of these procedures cursor <code>cur</code> has no current key/item pair.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Call <a href="#rm_read_next"><code>rm_read_next</code></a> or <a href="#rm_read_prev"><code>rm_read_prev</code></a> to read the next or previous key/item pair, resp., \
which then becomes the current key/value pair.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <a href="#rm_setll"><code>rm_setll</code></a> is called and the next key/item pair is removed from the map the \
cursor is positioned just after the previous pair. If <a href="#rm_setgt"><code>rm_setgt</code></a> is called and \
the previous key/item pair is removed from the map the cursor is positioned \
just before the next pair.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <a href="#rm_setll"><code>rm_setll</code></a> is called and there is no key equal to or greater, or if <a href="#rm_setgt"><code>rm_setgt</code></a> \
is called and there is no key equal to or less, the cursor is positioned at the end or beginning resp.<br>\
<span class="bullet1">&#9679;</span>&nbsp;These procedures dispose <code>key</code> automatically, unless <code>key</code> is a manually \
disposed map, or a value/map contained in a map.\
</p>\
\
');
