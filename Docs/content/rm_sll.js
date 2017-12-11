document.write('\
\
<div id="rm_sll"><div class="prochdr1">rm_sll</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Set lower limit</div></div>\
<pre class="proclongnm">rm_setll</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
cur pointer value<br>\
key pointer value options(*nopass)<br>\
</pre>\
<p>\
Position cursor <code>cur</code> on <code>key</code> and return <code>cur</code>.<br> \
Call <a href="#rm_sll"><code>rm_sll</code></a> to position the cursor just before the lowest key that is equal \
to or greater than <code>key</code>. Call <a href="#rm_sgt"><code>rm_sgt</code></a> to position the cursor just after the \
highest key that is equal to or less than <code>key</code>. If <code>key</code> is <code>*null</code> or not passed \
then the cursor is positioned at the beginning or the end, resp.<br>\
Call <a href="#rm_rdn"><code>rm_rdn</code></a> or <a href="#rm_rdp"><code>rm_rdp</code></a> to read the next or previous key/item pair, resp.<br>\
If <a href="#rm_sll"><code>rm_sll</code></a> is called and the next key/item pair is removed from the map the \
cursor is positioned just after the previous pair. If <a href="#rm_sgt"><code>rm_sgt</code></a> is called and \
the previous key/item pair is removed from the map the cursor is positioned \
just before the next pair.<br>\
If <a href="#rm_sll"><code>rm_sll</code></a> is called and there is no key equal to or greater, or if <a href="#rm_sgt"><code>rm_sgt</code></a> \
is called and there is no key equal to or less, the cursor is positioned at the end or beginning resp.<br>\
These procedures dispose <code>key</code> automatically, unless <code>key</code> is a manually \
disposed map, or a value/map contained in a map.\
</p>\
\
');