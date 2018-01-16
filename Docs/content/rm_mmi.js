document.write('\
\
<div id="rm_mmi"><div class="prochdr1">rm_mmi</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Make map immutable</div></div>\
<pre class="proclongnm">rm_make_map_immutable</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map pointer  value<br>\
opt char(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;Make <code>map</code> immutable, and return <code>map</code>.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;An immutable map can not be mutated, i.e. no key/item pairs can be inserted \
into or removed from the map. If a key/item pair is inserted into or removed \
from an immutable map then escape message RM00005 is sent.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;All contained <strong>automatically</strong> disposed maps (thus including vectors) are also \
made immutable, recursively.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;If <code>opt</code> is passed and is <code>\'*mm\'</code>"*mm" then all contained <strong>manually<strong> disposed maps are \
also made immutable, recursively, like contained automatically disposed maps.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;If <code>map</code> is already immutable then this operation has no effect.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;This operation can not be undone; an immutable map can not be made mutable again.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;When a map is copied (<a href="#rm_cpy"><code>rm_cpy</code></a>) then the new copy is mutable.\
</p>\
\
');
