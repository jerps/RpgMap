document.write('\
\
<div id="rm_sb"><div class="prochdr1">rm_sb</div><div class="prochdr2"> - Create a new string value, from binary</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value varchar(30000) const<br>\
opt   int(10)        value options(*nopass)<br>\
</pre>\
<p>\
Like <a href="#rm_s"><code>rm_s</code></a>, but <code>value</code> takes the raw bytes, already in utf8 format.<br>\
Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');