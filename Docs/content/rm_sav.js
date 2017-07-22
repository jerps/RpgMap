document.write('\
\
<div id="rm_sav"><div class="prochdr1">rm_sav</div><div class="prochdr2"> - Set attribute value</div></div>\
<pre class="proclongnm">rm_set_attr_val</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map   pointer                   value<br>\
attr  varchar(100) ccsid(*utf8) value options(*nopass)<br>\
value varchar(100) ccsid(*utf8) value options(*nopass)<br>\
</pre>\
<p>\
Set attribute named <code>attr</code> of <code>map</code> to <code>value</code> and return <code>map</code>.<br>\
If parameter <code>value</code> is not passed the attribute is "unset".<br>\
Parameters <code>attr</code> and <code>value</code> can be both not passed to "unset" \
all attributes at once (clear).<br>\
Each map can have one or more attributes set to a value, where \
each attribute has an utf8 name, and an utf8 value, both max. \
100 bytes. There is no restriction on attribute names and values.<br>\
Attribute names starting with "_" (underscore) should not be used \
as these are reserved for RpgMap.<br>\
Attributes are used to store settings and meta data that is used \
by different software modules, either built-in or external. Attributes \
should be named "module-name" where module is the name of the \
module or function and name is the attribute name. See the module\'s \
docs to see which attributes are used and their meaning.\
</p>\
\
');