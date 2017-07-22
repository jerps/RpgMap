document.write('\
\
<div id="rm_cmp"><div class="prochdr1">rm_cmp</div><div class="prochdr2"> - Compare two objects</div></div>\
<pre class="proclongnm">rm_compare</pre>\
<pre class="procsig">\
&lt;&lt;int(10)<br>\
obj1 pointer value<br>\
obj2 pointer value<br>\
</pre>\
<p>\
Compare <code>obj1</code> with <code>obj2</code>. They can be <code>*null</code>, a value or a map.<br>\
Return <code>-1</code> if <code>obj1</code> is less than <code>obj2</code>, return <code>1</code> if <code>obj1</code> is \
greater than <code>obj2</code>, return <code>0</code> if <code>obj1</code> and <code>obj2</code> are equal.<br>\
Two <code>*null</code>s are considered equal.<br>\
This is the default compare function for maps. The compare function \
of a map determines the ordering of the keys in the map. This can \
be overridden for a specific map with <a href="#rm_scf"><code>rm_scf</code></a>.<br>\
Two objects have a natural ordering when they are of the same kind:<br>\
- character data having the same sort sequence;<br>\
- strings having the same sort sequence;<br>\
- numbers;<br>\
- times;<br>\
- dates and timestamps;<br>\
- indicators (<code>*off</code> < <code>*on</code>);<br>\
- pointers;<br>\
- procedure pointers;<br>\
- maps.<br>\
If the objects don\'t have a natural order then they are ordered \
based on their type as follows:<br>\
</p>\
<pre>    <code>*null</code> < n < i < p < t < d < z < x < xp < a < aa < s < sa < m/v </pre>\
<p>\
Two maps are equal if they both have the exact same keys and items, \
in the same order.<br>\
The attributes of maps (<a href="#rm_sav"><code>rm_sav</code></a>) are ignored when doing comparisons \
between maps.<br>\
When two maps or a map and a vector are compared, then first the keys \
of the two maps are compared, in order. The lowest key of the first map \
is compared with the lowest key of the second map. If they are equal then \
the next two keys are compared, until the two keys are unequal or until \
the last key of one or both of the maps have been compared. If the two \
keys are unequal then the result is the comparison of these keys. If one \
map has no more keys but the other still has keys to compare then the \
latter is considered greater. If the keys of both maps are exactly the \
same then the items are compared using the same method. The items are \
one by one from each map, compared in key-order, starting with the two \
items with the lowest key, until the two items are unequal or until there \
are no items left.<br>\
When two vectors (maps created with <a href="#rm_v"><code>rm_v</code></a>) are compared the comparison \
is done in a special way. Only the items are compared (in key-order); \
not the keys. So the keys of two vectors may differ, but the vectors \
are still be considered equal when their items are equal. Also, if the \
vectors have a different number of items (keys) the extra items are \
ignored. So <code>rm_v(rm_d(d\'2017-01-01\'):rm_i(10))</code> and <code>rm_v(rm_d(d\'2017-01-01\'))</code> \
are considered equal. An empty vector, <code>rm_v()</code>, is equal to every other \
vector. The way two vectors are compared makes them suitable as (partial) \
composite keys.<br>\
When either one of <code>obj1</code> or <code>obj2</code> has the reversed order property \
(see <a href="#rm_"><code>rm_</code></a>) then the ordering between <code>obj1</code> and <code>obj2</code> is reversed \
wrt the normal ordering. What is normally greater than is now less \
than and vice versa (<code>*hival</code> has the lowest order).<br>\
When either one of <code>obj1</code> or <code>obj2</code> has the "case insensitive order" \
property (see <a href="#rm_"><code>rm_</code></a>) then both are compared such that there is no \
difference between uppercase and lowercase characters.<br>\
Character data and strings (char data in utf8 format) can have the \
special property that an alternate sort (collating) sequence is used \
to compare them. The specific sort sequence is fixed; it\'s set when \
RpgMap is built. When not explicitly changed it should be <code>*langidshr</code>. \
When two character data fields or two strings are compared with each \
other and both have this property then the comparison is done using \
the alternate sort sequence.<br>\
Strings must be converted first to the job CCSID before they can be \
compared using the alternate sort sequence. This takes considerably \
more resources than when the default sort sequence is used.<br>\
</p>\
\
');