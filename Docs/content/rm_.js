document.write('\
\
<div id="rm_"><div class="prochdr1">rm_</div><div class="prochdr2"> - Set special property</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
obj pointer value<br>\
opt int(10) value options(*nopass)<br>\
</pre>\
<p>\
Set the special property identified with <code>opt</code> which is <code>0</code> for \
"reversed order", <code>1</code> for "case insensitive order", or <code>2</code> for both, \
for <code>obj</code>, which is a map or value, and return <code>obj</code>.<br>\
If <code>opt</code> is not passed then 0 is assumed.<br>\
Some properties are not supported for some types.<br>\
Send escape message RM00111 if <code>opt</code> is not supported.<br>\
A special property should be set once, when needed, immediately after \
creating the map or value.<br>\
For values, it\'s better to use parameter <code>opt</code> when creating the value, \
such as <code>rm_i(1:0)</code>, which creates integer value 1 with reversed order. \
When creating maps there is no <code>opt</code> parameter so <a href="#rm_"><code>rm_</code></a> must be used \
instead.<br>\
- Reversed Order<br>\
If a map or value has the "reversed order" property, then when it\'s \
compared to other maps or values the sort order is reversed. Value \
<code>*hival</code> is then the lowest in order, and vice versa. When comparing \
two objects, reversed order is in effect when at least one has the \
reversed order property set, otherwise normal order is in effect.<br>\
- Case Insensitive Order<br>\
If <code>obj</code> is character data or a string, with normal sort sequence, \
then the "case insensitive order" can be set. If set, then when <code>obj</code> \
is compared with other character data or strings this is done without \
difference between uppercase and lowercase characters.<br>\
Some extra processing is required when a case insensitive comparison \
is done. Especially when setting this property for strings, as they \
also need to be converted to the job CCSID first, before being compared \
case insensitive.\
</p>\
\
');