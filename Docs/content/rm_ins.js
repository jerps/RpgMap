document.write('\
\
<div id="rm_ins"><div class="prochdr1">rm_ins</div><div class="prochdr2"> - Insert key/item pairs</div></div>\
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
Insert up to 100 new key/item pairs into <code>map</code> and return <code>map</code>.<br>\
The keys and items must be maps or values. Values are automatically \
disposed when their containing map is disposed, or when the key/item \
is removed from the map. Maps that are not created with <a href="#rm_mm"><code>rm_mm</code></a> are \
also automatically disposed, just like values.<br>\
A key/item pair is inserted into a specific slot, depending on the \
key\'s order among the other keys. This slot is fixed and the key\'s \
order should not be affected by changing the key\'s contents and/or \
properties.<br>\
Values and maps that are automatically disposed can only be inserted \
once into a map. When an automatically disposed map or a value is \
inserted into a map and the map/value has already been inserted into \
a map then escape message RM00010/RM00012 is sent.<br>\
Keys can not be <code>*null</code>.<br>\
Items can be <code>*null</code>.<br>\
A map is allowed to contain duplicate keys (i.e. keys that are equal). \
If <code>map</code> already contains one or more keys that are equal to <code>key</code> then \
<code>key</code> is inserted at the end. Searching among equal keys is linear \
time, O(n), and lots of duplicates and/or "equal" searches should therefore \
be avoided.<br>\
Starting at the second argument, every even and uneven argument corresponds \
to a key/item pair that is to be inserted. Pairs where the key is <code>*null</code> \
are ignored.<br>\
Items which were not inserted (because no key was specified) will be \
disposed, unless the item is a manually disposed map, or a value/map \
contained in a map.\
</p>\
\
');