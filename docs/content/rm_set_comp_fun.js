document.write('\
\
<div id="rm_set_comp_fun"><div class="prochdr1">rm_set_comp_fun</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Set compare function</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer        value<br>\
comp pointer(*proc) value<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Set the compare function of <code>map</code>, which must be empty, to <code>comp</code>, \
and return <code>map</code>. Send escape messsage RM00041 if <code>map</code> is not empty.<br>\
<span class="bullet1">&#9679;</span>&nbsp;The compare function of <code>map</code> determines how the keys in <code>map</code> are \
compared/ordered. Normally <a href="#rm_compare"><code>rm_compare</code></a> is used as the compare function, \
but this can be overridden with another compare function, <code>comp</code>, for \
a specific map. When two keys that are both maps are compared, the \
order in which the keys and items are compared is determined by the \
compare functions of the two maps. But when two keys or items, from \
these two maps, are compared then the compare function of the containing \
map is used. Unless this behavior is changed with another \
compare function.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Procedure <code>comp</code> must have the following signature:\
</p>\
<pre class="procsig">\
  rtn type: int(10)<br>\
  par. 1  : obj1 pointer value<br>\
       2  : obj2 pointer value<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Procedure <code>comp</code> compares <code>obj1</code> and <code>obj2</code>, which can be <code>*null</code> or \
a value or a map, and returns <code>0</code> of they\'re equal, <code>-1</code> if <code>obj1</code> is \
less than </code>obj2</code>, or <code>1</code> if <code>obj1</code> is greater than <code>obj2</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>comp</code> returns something else than <code>0</code>, <code>1</code> or <code>-1</code> then the comparison \
falls back to <a href="#rm_compare"><code>rm_compare</code></a>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>comp</code> is <code>*null</code> then <a href="#rm_compare"><code>rm_compare</code></a> is reset to be used as the compare \
function again.<br>\
<span class="bullet1">&#9679;</span>&nbsp;The following is a simple example of a <code>comp</code> procedure body, which \
has the effect that the sort order is reversed: <code>return rm_compare(obj1:obj2)*-1;</code>.\
</p>\
\
');
