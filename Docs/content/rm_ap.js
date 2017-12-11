document.write('\
\
<div id="rm_ap"><div class="prochdr1">rm_ap</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new character data value, pointer to data</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
addr pointer value<br>\
size int(10) value<br>\
opt  int(10) value options(*nopass)<br>\
</pre>\
<p>\
Like <a href="#rm_a"><code>rm_a</code></a>, but the data is taken from a pointer and a number of bytes (size).<br>\
The size must be between 1 and 30.000.<br>\
The passed number of bytes (<code>size</code>) are copied from the address to which \
the pointer (<code>addr</code>) points.<br>\
Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');