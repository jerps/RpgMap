document.write('\
\
<h2 id="vectors">Vectors</h2>\
<br>\
<p>\
A vector is a special automatically disposed map, created with <a href="#rm_v"><code>rm_v</code></a>. \
It\'s mainly used for representing a list or a sequence, particularly a (partial) composite key. \
A composite key is a key that is not one value, but a sequence of 1 or more values. See <a href="#example_2">example 2</a>.\
</p>\
<p>\
The keys of a vector must always be integers.\
</p>\
<p>\
The expression <code>rm_v(rm_a(\'a\'):rm_a(\'b\'))</code> creates a vector, i.e. a map, with keys <code>1</code> \
and <code>2</code> and items <code>\'a\'</code> and <code>\'b\'</code>. Only the items are specified. \
The keys are automatically generated; the first item gets key <code>rm_i(1)</code>, the second item gets key <code>rm_i(2)</code>, etc.\
</p>\
<p>\
When two vectors are compared the comparison is done differently than when two normal maps or a map and a vector \
are compared. The keys are not compared, only the items (in key order). But unlike with maps, when the two vectors \
have a different number of key/item pairs then only the first n key/item pairs from both vectors are relevant. \
The extra key/item pairs from one of the two vectors are ignored. For example, vectors <code>rm_v(rm_i(1):rm_i(2))</code> \
and <code>rm_v(rm_i(1))</code> are considered equal because only the first item of each vector are relevant. See \
<a href="#rm_cmp"><code>rm_cmp</code></a> for details.\
</p>\
<p>\
Up to 100 key/item pairs can be immediately inserted with procedure <a href="#rm_v"><code>rm_v</code></a>. \
Only the items need to be specified: the keys are implied (<code>rm_i(1)</code>, <code>rm_i(2)</code>, ...). \
So <a href="#rm_v"><code>rm_v</code></a> is often used to represent a simple "list" or "sequence".\
</p>\
\
');
