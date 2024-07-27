# Nupk
Dummy package manager in roughly 350 lines of shell script.
NOT USABLE YET, IT'S JUST A DRAFT

To make it work, you'll need:
+ Some core utilities, namely: `basename`, `cat`, `cd`, `cp`, `mkdir`, `mv`, `rm`,`printf`, `rmdir`, `sort`, `unlink`
+ `awk`, `diff` and `sed` for text manipulation
+ `tar` and `gzip` to pack and unpack tarballs
+ `curl` to download patches, tarballs and such
+ `git` to clone repos
+ `su` for priviledge elevation

Note: you may need more than just gzip to handle archives, since some packages
use other extensions.

It _should_ contain no unorthodox features, e.g. GNU Bash extensions (and if not, it's probably close)

At the moment, you'll need to become root once to change ownership of the tarball,
once to move it to `$NUPK_BINARIES` and once to install it. That is, you'll be asked
for a password three times. This is, of course, silly, and it ought to change.
