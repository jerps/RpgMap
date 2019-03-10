document.write('\
\
<div id="rm_sb"><div class="prochdr1">rm_sb</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new string value, from binary</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value varchar(30000) const<br>\
opt   int(10)        value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Like <a href="#rm_s"><code>rm_s</code></a>, but <code>value</code> passes the raw bytes that is already in utf-8 format.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');
