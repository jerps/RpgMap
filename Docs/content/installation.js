document.write('\
\
<h1 id="installation">Installation</h1>\
<br>\
<p>\
RpgMap is on <a href="http://github.com/jerps/RpgMap">Github</a>. It\'s installed by putting library RPGMAP on your i. At the moment RpgMap can \
only be installed by building it from source. A current ILE RPG compiler is required: \
at least 7.2 TR5.\
</p>\
<h2>Building library RPGMAP from source</h2>\
<p>\
Download <a href="https://github.com/jerps/RpgMap/releases/download/v1.1.0/RpgMap-v1.1.0.zip">RpgMap-v1.1.0.zip</a> and put it somewhere on the IFS, e.g. /home/...<br>\
If you didn\'t already, start QSH (QSHELL, not PASE).<br>\
Cd into the directory with the zip file.<br>\
Unzip the file with <code>jar xvf RpgMap-v1.1.0.zip</code>.<br>\
Cd into directory "RpgMap-master/Source".<br>\
Start the build with <code>chmod +x BUILD.sh && ./BUILD.sh</code>.<br>\
The last message should say "OK; serviceprogram RPGMAP/RPGMAP has been created.".\
</p>\
<h3>Changing the alternate sort sequence</h3>\
<p>\
The alternate sort sequence used for values such as <a href="#rm_aa"><code>rm_aa</code></a> \
is determined at build time. Variable <code>SRTSEQ</code> in build script BUILD.sh can be set to the \
desired sort sequence. By default the RPG module is compiled with <code>altseq(*EXT)</code> and \
<code>srtseq(*LANGIDSHR)</code>.\
</p>\
\
');