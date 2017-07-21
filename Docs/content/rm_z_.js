document.write('\
\
<div id="rm_z_"><div class="prochdr1">rm_z_</div><div class="prochdr2"> - Convert a date/timestamp to an RPG timestamp value</div></div>\
<pre class="procsig">\
&lt;&lt;timestamp<br>\
value   pointer   value<br>\
default timestamp value options(*nopass)<br>\
</pre>\
<p>\
Return an RPG timestamp from <code>value</code>, which must be a date or timestamp.<br>\
If <code>value</code> is <code>*null</code> then return <code>*loval</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
A date is converted to a timestamp using BIF %timestamp.\
</p>\
\
');