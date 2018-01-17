document.write('\
\
<div id="rm_hks"><div class="prochdr1">rm_hks</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Has keys?</div></div>\
<pre class="proclongnm">rm_has_keys</pre>\
<pre class="procsig">\
&lt;&lt;ind<br>\
map pointer  value<br>\
key pointer  value<br>\
opt char(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>opt</code> is <code>\'*ge\'</code> or not passed, then return <code>*on</code> if <code>map</code> has keys that \
are equal to or greater than <code>key</code>, else return <code>*off</code>. If <code>opt</code> is <code>\'*le\'</code> \
then return <code>*on</code> if <code>map</code> has keys that are equal to or less than <code>key</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;This procedure disposes <code>key</code> automatically, unless <code>key</code> is a manually \
disposed map, or a value/map contained in a map.\
</p>\
\
');
