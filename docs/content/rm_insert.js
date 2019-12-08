document.write('\
\
<div id="rm_insert"><div class="prochdr1">rm_insert</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Insert key/item pairs</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer value<br>\
k001 pointer value options(*nopass)<br>\
i001 pointer value options(*nopass)<br>\
...<br>\
k100 pointer value options(*nopass)<br>\
i100 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Insert up to 100 new key/item pairs into <code>map</code> and return <code>map</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;The keys and items must be maps or values. Values are automatically \
disposed when their containing map is disposed, or when the key/item \
is removed from the map. Maps that are not created with <a href="#rm_mm"><code>rm_mm</code></a> are \
also automatically disposed, just like values.<br>\
<span class="bullet1">&#9679;</span>&nbsp;A key/item pair is inserted into a specific slot, depending on the \
key\'s order among the other keys. This slot is fixed and the key\'s \
order should not be affected by changing the key\'s contents and/or \
properties.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Values and maps that are automatically disposed can only be inserted \
once into a map. When an automatically disposed map or a value is \
inserted into a map and the map/value has already been inserted into \
a map then escape message RM00010/RM00012 is sent.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Keys can not be <code>*null</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Items can be <code>*null</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;A map is allowed to contain duplicate keys (i.e. keys that are equal). \
If <code>map</code> already contains one or more keys that are equal to <code>key</code> then \
<code>key</code> is inserted at the end. Searching among equal keys is linear \
time, O(n), and lots of duplicates and/or "equal" searches should therefore \
be avoided.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Starting at the second argument, every even and uneven argument corresponds \
to a key/item pair that is to be inserted. Pairs where the key is <code>*null</code> \
are ignored.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Items which were not inserted (because no key was specified) will be \
disposed, unless the item is a manually disposed map, or a value/map \
contained in a map.\
</p>\
\
');
