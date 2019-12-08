document.write('\
\
<div id="rm_set_attr_val"><div class="prochdr1">rm_set_attr_val</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Set attribute values</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer                   value<br>\
a001 varchar(100) ccsid(*utf8) value options(*nopass)<br>\
v001 varchar(100) ccsid(*utf8) value options(*nopass)<br>\
...<br>\
a100 varchar(100) ccsid(*utf8) value options(*nopass)<br>\
v100 varchar(100) ccsid(*utf8) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Set up to 100 attributes of <code>map</code> to a value and return <code>map</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Each map can have one or more attributes set to a value, where \
each attribute has an utf-8 name, and an utf-8 value, both max. 100 bytes. There is no restriction on attribute names and values.<br>\
<span class="bullet1">&#9679;</span>&nbsp;The first attribute name and value is passed with parameters 2 and 3, \
<code>a001</code> and <code>v001</code>, the second with <code>a002</code> and <code>v002</code>, etc.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Send escape message RM00102 if an attribute name is blank or empty.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If a value is not passed or it is blank or empty then the attribute \
is "unset".<br>\
<span class="bullet1">&#9679;</span>&nbsp;If no attribute names or values are passed at all (i.e. only <code>map</code> \
is passed) then every attribute of <code>map</code> is unset (all are cleared).<br>\
<span class="bullet1">&#9679;</span>&nbsp;Attributes are used to store settings and meta data that is used \
by different software modules/applications, either built-in or external. \
Attributes should be named "<i>module</i>-<i>name</i>" where <i>module</i> is the name of the \
module or function and <i>name</i> is the attribute name. The module\'s docs \
should specify the attributes that are used and their meaning.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Attribute names starting with "_" (underscore) should not be used \
as these are reserved for RpgMap.\
</p>\
\
');
