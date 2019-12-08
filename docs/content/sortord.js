document.write('\
\
<h2 id="sortord">Sort Order</h2>\
<br>\
<p>\
The order of a key in a map is determined by the compare function of the map. By default this \
is <a href="#rm_cmp"><code>rm_cmp</code></a>. This compare function can be replaced by another \
(but only when the map is empty). See <a href="#rm_set_comp_fun"><code>rm_set_comp_fun</code></a>.\
</p>\
<p>\
The sort order, when values and maps are compared with each other, is influenced by whether the compared \
maps and/or values have the "reversed order" and/or "case insensitive order" property (see <a href="#rm_"><code>rm_</code></a>) \
and/or whether character data or strings are sorted using an alternate sort sequence (<a href="#rm_aa"><code>rm_aa</code></a>, <a href="#rm_sa"><code>rm_sa</code></a>).\
</p>\
<p>\
Procedure <a href="#rm_cmp"><code>rm_cmp</code></a> compares values and maps and uses the alternate \
sort sequence, and/or the "case insensitive order" property to determine the order, if applicable. \
However, when <a href="#rm_cmp"><code>rm_cmp</code></a> is replaced, "alternate sort sequence" and the \
"case insensitive order" property are not guaranteed to function as expected anymore, depending on the \
logic of the new compare function. The "reversed order property" will always function as expected; it can \
can not be ignored or altered by a new compare function.\
</p>\
\
');
