document.write('\
\
<div id="rm_z_"><div class="prochdr1">rm_z_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert a date/timestamp to an RPG timestamp value</div></div>\
<pre class="procsig">\
&lt;&lt;timestamp<br>\
value   pointer   value<br>\
default timestamp value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8407;</span>&nbsp;Return an RPG timestamp from <code>value</code>, which must be a date or timestamp.<br>\
<span class="bullet1">&#8407;</span>&nbsp;If <code>value</code> is <code>*null</code> then return <code>*loval</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
<span class="bullet1">&#8407;</span>&nbsp;A date is converted to a timestamp using BIF %timestamp.\
</p>\
\
');
