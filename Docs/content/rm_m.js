document.write('\
\
<div id="rm_m"><div class="prochdr1">rm_m</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new map, automatically disposed</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
k001 pointer value options(*nopass)<br>\
i001 pointer value options(*nopass)<br>\
...<br>\
k100 pointer value options(*nopass)<br>\
i100 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Create a new map and return a pointer to it.<br>\
<span class="bullet1">&#8226;</span>&nbsp;The map should be disposed - with <a href="#rm_dis"><code>rm_dis</code></a> \
- when it\'s not needed anymore. If the map is inserted into a map as a key or item it will \
be automatically disposed when the containing map is disposed or when \
the key/item is removed, and <a href="#rm_dis"><code>rm_dis</code></a> can not be used \
anymore to dispose the map.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Like a value, an automatically disposed map can be inserted into \
(contained in) one map only, i.e. it can be inserted only once (even \
when inserting into the same map). Escape message RM00010 will be sent \
if an automatically disposed map is inserted into a map for a second time.<br>\
<span class="bullet1">&#8226;</span>&nbsp;The new map can be immediately populated with key/item pairs by passing \
the keys and items as arguments. This is the same as calling <a href="#rm_ins1"><code>rm_ins1</code></a> \
repeatedly, with arguments 1 and 2 as the first key and item, resp., \
arguments 3 and 4 as the second key and item, etc. Up to 100 key/item \
pairs can be passed. An item is optional (or <code>*null</code>). Key/items \
of which the key is <code>*null</code> are ignored.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Items which were not inserted because no key was specified will be \
disposed, unless the item is a manually disposed map, or a value/map \
contained in a map.\
</p>\
\
');