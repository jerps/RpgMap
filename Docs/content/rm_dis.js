document.write('\
\
<div id="rm_dis"><div class="prochdr1">rm_dis</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Dispose maps, cursors and values</div></div>\
<pre class="proclongnm">rm_dispose</pre>\
<pre class="procsig">\
&lt;&lt;-<br>\
o001 pointer value options(*nopass)<br>\
...<br>\
o100 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Dispose objects <code>o001</code> thru <code>o100</code>. Each object can be a map, a cursor \
or a value.<br>\
<span class="bullet1">&#8226;</span>&nbsp;When an object is disposed its memory is released/freed.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Use this procedure when a map, cursor or value is not used anymore.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If a map is disposed then all associated cursors are also disposed.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If a map is disposed then all its keys and items are also disposed, i.e. \
all contained maps and values are disposed except manually disposed maps, \
which must always be disposed directly using <a href="#rm_dis"><code>rm_dis</code></a>.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Values and automatically disposed maps that are contained in (have been \
inserted into) a map can not be directly disposed with <a href="#rm_dis"><code>rm_dis</code></a>.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Send escape message RM00030 if the object to dispose is a value that is \
contained in a map, or is an automatically disposed map that is contained \
in a map.\
</p>\
\
');