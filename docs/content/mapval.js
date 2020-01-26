document.write('\
\
<h2 id="mapval">Maps and Values</h2>\
<br>\
<p>\
Maps contain values and other maps, as key/item pairs, that are always sorted by key. For example the keys could be \
customer numbers and the items customer records. Items can be accessed very fast using the associated key due to the \
keys being indexed using an efficient red-black tree algorithm.\
</p>\
<p>\
There are two distinct types of maps: manually and automatically disposed maps. They differ mainly in the way they\'re \
handled with respect to <a href="#amemmgt">Automatic Memory Management</a>.\
</p>\
<p>\
Key/item pairs are inserted into and removed from maps. When a key or item is removed it\'s immediately disposed \
(i.e. memory is freed), except when it\'s a <a href="#amemmgt">manually disposed map</a>.\
</p>\
<p>\
Throughout this documentation maps and values are said to be "contained" by maps. No distinction is being made between \
automatically or manually disposed maps. Strictly speaking this is not correct. Contained means "being part of" and that \
does not apply to <strong>manually</strong> disposed maps. That\'s why unlike automatically disposed maps, manually disposed maps can be \
"contained" in more than one map. More accurately, a reference (i.e. a pointer) to the "contained" manually disposed \
map is contained in each map that is said to "contain" - but more accurately <strong>references</strong> - the map. However, \
the documentation uses the term "contained" for both map types.\
</p>\
<p>\
Maps are created with <a href="#rm_m"><code>rm_m</code></a>, <a href="#rm_mm"><code>rm_mm</code></a> or <a href="#rm_v"><code>rm_v</code></a>.\
</p>\
<p>\
Key/item pairs are inserted into a map with one of the <code>rm_insert*</code> procedures such as <a href="#rm_insert"><code>rm_insert</code></a> \
or <a href="#rm_insert_c"><code>rm_insert_c</code></a>. When creating a map, the keys and items to insert can be \
immediately specified (see <a href="#example_1">example 1</a>).\
</p>\
<p>\
Duplicate keys are allowed. An RpgMap is not a MultiMap; a key is associated with only one item. Key/item pairs with equal key \
are simply stored multiple times with the same key, retaining insertion order.\
</p>\
<p>\
Key/item pairs are removed from a map with <a href="#rm_remove"><code>rm_remove</code></a> and <a href="#rm_remove_all"><code>rm_remove_all</code></a>.\
</p>\
<p>\
Items are retrieved by key with the following procedures: <a href="#rm_get"><code>rm_get</code></a>, \
<a href="#rm__"><code>rm__</code></a> and e.g. <a href="#rm__i"><code>rm__i</code></a> and all variants (every \
value type has a corresponding <code>rm__??</code> procedure).\
</p>\
<p>\
RPG values can not be directly inserted into a map. They must first be "wrapped" into a RpgMap value that <i>can</i> \
be inserted into a map. Also, RpgMap procedures such as <a href="#rm_get"><code>rm_get</code></a> often expect their \
map/value arguments to be these RpgMap values. They are created with the <code>rm_??</code> procedures which return a \
pointer to an opaque RpgMap data structure which represents this value. For example: <a href="#rm_i"><code>rm_i</code></a> \
for <code>int(10)</code> values, <a href="#rm_p2"><code>rm_p2</code></a> for <code>packed(28:8)</code> values, <a href="#rm_ap"><code>rm_ap</code></a> \
for character data values given with a pointer, etc. Look into the <a href="#api"><code>API</code></a> for a full list.\
</p>\
<p>\
As explained previously a <code>rm_??</code> procedure wraps a normal RPG value into a special value (data structure) that \
can be handled by RpgMap. Every <code>rm_??</code> procedure has a <code>rm_??_</code> procedure (with trailing underscore) \
which does the opposite and unwraps the RPG value again. For example, <a href="#rm_t"><code>rm_t</code></a> wraps a RPG time value \
and <a href="#rm_t_"><code>rm_t_</code></a> unwraps, or converts, it back to a normal RPG time value. When unwrapping/converting \
certain data type conversions may happen. For example <a href="#rm_i_"><code>rm_i_</code></a> can convert packed decimal \
values to integers, and <a href="#rm_t_"><code>rm_t_</code></a> can convert timestamps to time values. If the types are \
incompatible escape message RM00011 (value is not compatible) is sent.\
</p>\
<p>\
Every <code>rm_??_</code> procedure is accompanied by a <code>rm_??__</code> procedure (with two trailing underscores) that \
disposes the RpgMap value with <a href="#rm_dispose"><code>rm_dispose</code></a> when it has been unwrapped.\
</p>\
<p>\
For most <code>rm_??</code> procedures there is also a <code>rm_is??</code> procedure to test whether an object is \
of that certain type.\
</p>\
<p>\
This wrapping/unwrapping of RPG values using <code>rm_??</code> and <code>rm_??_</code> is necessary to make RpgMap \
polymorphic, i.e. to let it handle different types uniformly.\
</p>\
<p>\
A map can be made immutable with <a href="#rm_make_map_immutable"><code>rm_make_map_immutable</code></a>. There is no way to make it mutable again. This \
guarantees that no key/item pairs will be inserted into or removed from the map. If a map is made immutable then all contained \
<strong>automatically</strong> disposed maps (thus including vectors) are made immutable also, recursively.\
</p>\
<p>\
Event handlers can be <a href="#rm_add_event_handler">added</a> to (or <a href="#rm_remove_event_handler">removed</a> from) \
a map to call procedures whenever key/item pairs are inserted or removed.\
</p>\
<p>\
Maps and values can be associated with application specific "user data", which is an integer value from 1 to 65.000. \
See <a href="#rm_"><code>rm_</code></a>.\
</p>\
<p>\
When creating a value (not a map), e.g. with <a href="#rm_a_"><code>rm_a_</code></a>, optional parameter <code>opt</code> can be \
passed to immediately set a special property of the new value (such as "reversed order"), or to provide user data. \
See <a href="#rm_"><code>rm_</code></a>.\
</p>\
\
');
