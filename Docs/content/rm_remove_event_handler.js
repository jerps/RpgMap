document.write('\
\
<div id="rm_remove_event_handler"><div class="prochdr1">rm_remove_event_handler</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Remove event handler</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map   pointer        value<br>\
hproc pointer(*proc) value<br>\
</pre>\
<p>\
Remove event handler <code>hproc</code> from the list of event handlers registered \
for <code>map</code>, and return <code>map</code>.<br>\
If the handler was added mutiple times then only the last one added \
is removed.<br>\
Do nothing if the handler isn\'t found.\
</p>\
\
');