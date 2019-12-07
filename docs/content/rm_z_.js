document.write('\
\
<div id="rm_z_"><div class="prochdr1">rm_z_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert date/timestamp to RPG timestamp value</div></div>\
<pre class="procsig">\
&lt;&lt;timestamp<br>\
value   pointer   value<br>\
default timestamp value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Return an RPG <code>timestamp</code> from <code>value</code>, which must be a date or timestamp.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>value</code> is <code>*null</code> then return <code>*loval</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
<span class="bullet1">&#9679;</span>&nbsp;A date is converted to a timestamp using BIF %timestamp.\
</p>\
\
');
