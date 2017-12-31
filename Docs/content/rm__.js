document.write('\
\
<div id="rm__"><div class="prochdr1">rm__</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Retrieve item with one or more keys</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map pointer value<br>\
k01 pointer value options(*nopass)<br>\
...<br>\
k10 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Like <a href="#rm_get"><code>rm_get</code></a>, but procedures <code>rm__??</code> retrieve an item using one or more \
keys. There is a version for each data type, so that the keys can be given \
as normal RPG data types (although they can\'t be intermixed).<br>\
<span class="bullet1">&#8226;</span>&nbsp;When multiple keys are given the item is retrieved through one or more \
nested maps.<br>\
<span class="bullet1">&#8226;</span>&nbsp;First the item in <code>map</code> with key equal to the first passed key is retrieved. \
If found and the item is a map and there is a second key passed then the item \
in this map with key equal to the second key is retrieved, etc. Return the last \
item retrieved, or <code>*null</code> if a key was not found in a map or if there are more \
keys passed than there are nested maps.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Up to 10 keys can be passed. Parameters <code>k01</code> through <code>k10</code> are all \
optional. If none are passed then <code>*null</code> is returned. Keys that are <code>*null</code> \
are ignored.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Use procedure <a href="#rm__"><code>rm__</code></a> as a generic procedure which accepts keys of any type. \
Use procedures <code>rm__??</code> as a shortcut to pass keys as normal RPG values \
of a certain type. For character and string keys up to 200 bytes can be \
passed.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If there are multiple keys equal to <code>key</code> then the first one is selected.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Procedure <code>rm__</code> disposes all passed keys automatically, unless a key is \
a manually disposed map, or a value/map contained in a map.\
</p>\
\
');