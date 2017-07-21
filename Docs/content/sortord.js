document.write('\
\
<h2 id="sortord">Sort Order</h2>\
<p>\
The order of a key in a map is determined by the compare function of the map. By default this \
is <a href="#rm_cmp"><code>rm_cmp</code></a>. This compare function can be replaced by another \
(but only when the map is empty). See <a href="#rm_scf"><code>rm_scf</code></a>.\
</p>\
<p>\
The sort order when values and maps are compared with each other is influenced by whether they have the \
"reversed order" property (see <a href="#rm_"><code>rm_</code></a>), and/or whether character \
data or strings are sorted using an alternate sort sequence (<a href="#rm_aa"><code>rm_aa</code></a>, <a href="#rm_sa"><code>rm_sa</code></a>) \
or whether they have the "case insentive order" property (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
<p>\
Procedure <a href="#rm_cmp"><code>rm_cmp</code></a> implements comparing values using the alternate \
sort sequence, and the "case insensitive order" property. So when <a href="#rm_cmp"><code>rm_cmp</code></a> \
is replaced, alternate sort sequence and the "case insensitive order" property is not guaranteed to function \
correctly anymore.\
</p>\
<p>\
The "reversed order property" is implemented "above" the compare function.\
</p>\
\
');