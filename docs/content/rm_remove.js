document.write('\
\
<div id="rm_remove"><div class="prochdr1">rm_remove</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Remove key/item pair</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map pointer  value<br>\
key pointer  value<br>\
opt char(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Remove the key/item pair with key equal to <code>key</code> from <code>map</code>, if \
found, and return <code>map</code>. If not found do nothing, and return <code>map</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If the key and/or item is a value or an automatically disposed map \
then they\'re disposed.<br>\
<span class="bullet1">&#9679;</span>&nbsp;In case there are multiple keys equal to <code>key</code> then <code>opt</code> indicates \
which key: <code>\'*f\'</code> or <code>\'*first\'</code> for the first one (which is the default), \
or <code>\'*l\'</code> or <code>\'*last\'</code> for the last one.<br>\
<span class="bullet1">&#9679;</span>&nbsp;This procedure disposes <code>key</code> automatically, unless <code>key</code> is a manually \
disposed map, or a value/map contained in a map.\
</p>\
\
');
