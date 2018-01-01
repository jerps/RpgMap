document.write('\
\
<div id="rm_cur"><div class="prochdr1">rm_cur</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new cursor</div></div>\
<pre class="proclongnm">rm_cursor</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map pointer  value<br>\
opt char(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;Return a new cursor for <code>map</code>. The cursor is positioned at the beginning \
or the end, depending on whether <code>opt</code> is <code>\'*b\'</code>/<code>\'*begin\'</code> or <code>\'*e\'</code>/<code>\'*end\'</code>, \
resp. Optional parameter <code>opt</code> defaults to <code>\'*b\'</code>.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;The cursor should be disposed with <a href="#rm_dis"><code>rm_dis</code></a> when it\'s not used anymore. It \
is automatically disposed when <code>map</code> is disposed.\
</p>\
\
');
