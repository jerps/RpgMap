document.write('\
\
<div id="rm_s"><div class="prochdr1">rm_s</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new string value</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value varchar(30000) ccsid(*utf8) const<br>\
opt   int(10)                     value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;Create a new string value, up to 30.000 bytes long.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;A string is character data (text) in utf-8 format.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;The raw bytes can be accessed with <a href="#rm_a_"><code>rm_a*_</code></a>.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');
