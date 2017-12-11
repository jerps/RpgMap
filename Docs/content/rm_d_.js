document.write('\
\
<div id="rm_d_"><div class="prochdr1">rm_d_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert a date/timestamp to an RPG date value</div></div>\
<pre class="procsig">\
&lt;&lt;date<br>\
value   pointer value<br>\
default date    value options(*nopass)<br>\
</pre>\
<p>\
Return an RPG date from <code>value</code>, which must be a date or timestamp.<br>\
If <code>value</code> is <code>*null</code> then return <code>*loval</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
A timestamp is converted to a date using BIF %date.\
</p>\
\
');