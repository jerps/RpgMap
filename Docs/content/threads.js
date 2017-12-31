document.write('\
\
<h2 id="threads">Threads</h2>\
<br>\
<p>\
RpgMap is not threadsafe. That means that when multiple threads are active in a job that uses RpgMap, care should \
be taken that only one thread reads or writes the same map. This can be done using synchronization constructs \
such as locks, sempahores or mutexes. One could simply specify control-options keyword <code>thread(*serialize)</code> \
for an RPG module, and make sure that all access to maps is done through that module. This ensures that only one \
thread accesses any map at some moment in time. This solution has a coarse granularity. It hinders performance \
when many threads are waiting and there is a greater risk for deadlocks. However, for most practical situations \
using <code>thread(*serialize)</code> would be good enough.\
</p>\
\
');