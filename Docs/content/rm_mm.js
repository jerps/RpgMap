document.write('\
\
<div id="rm_mm"><div class="prochdr1">rm_mm</div><div class="prochdr2"> - Create a new map, manually disposed</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
k001 pointer value options(*nopass)<br>\
i001 pointer value options(*nopass)<br>\
...<br>\
k100 pointer value options(*nopass)<br>\
i100 pointer value options(*nopass)<br>\
</pre>\
<p>\
Same as <a href="#rm_m"><code>rm_m</code></a> except that the new map is not automatically disposed \
and must always be manually disposed with <a href="#rm_dis"><code>rm_dis</code></a>. However, unlike automatically disposed \
maps, a manually disposed map can be inserted into multiple maps.\
</p>\
\
');