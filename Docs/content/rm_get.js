document.write('\
\
<div id="rm_get"><div class="prochdr1">rm_get</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Retrieve item with a key</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map pointer  value<br>\
key pointer  value<br>\
opt char(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8407;</span>&nbsp;Return the item of the key/item pair in <code>map</code> with key equal to <code>key</code>.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Return <code>*null</code> if not found.<br>\
<span class="bullet1">&#8407;</span>&nbsp;In case there are multiple keys equal to <code>key</code> then <code>opt</code> indicates \
which key: <code>\'*f\'</code> or <code>\'*first\'</code> for the first one (which is the default), \
or <code>\'*l\'</code> or <code>\'*last\'</code> for the last one.<br>\
<span class="bullet1">&#8407;</span>&nbsp;This procedure disposes <code>key</code> automatically, unless <code>key</code> is a manually \
disposed map, or a value/map contained in a map.\
</p>\
\
');
