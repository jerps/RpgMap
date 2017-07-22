document.write('\
\
<h2 id="examples">Examples</h2>\
<p>\
Many procedures have <a href="#longprnms">both a short name and a long(er) name</a>. Examples 1 and 2 use the long names. \
Example 3 uses the short names.\
</p>\
<p>\
The examples use the following procedure, <code>display</code>.\
</p>\
<pre class="pcode">\
dcl-proc display;<br>\
dcl-pi *n;<br>\
  text varchar(500) value;<br>\
end-pi;<br>\
  dcl-s t char(52);<br>\
  t = text;<br>\
  dsply t;<br>\
end-proc;<br>\
</pre>\
\
');