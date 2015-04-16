#!/bin/sh

GITDIR=$HOME/git.ceph.com
MIRRORDIR=$HOME/git/mirror
BINDIR=$HOME/git

origin=$2
[ -z "$origin" ] && origin=git://github.com/ceph/$1

cd $GITDIR
test -d $1.git && rm -rf $1.git
git clone --bare --mirror $origin
cat $BINDIR/config.fragment.txt >> $GITDIR/$1.git/config

cd $MIRRORDIR
test -d $1.git && rm -rf $1.git
git clone --bare $origin
cd $1.git
echo > description
ln -s $BINDIR/post-receive-email hooks/post-receive
cat $BINDIR/mirror.fragment.txt >> config

git remote set-url origin $GITDIR/$1.git

cd $GITDIR/$1.git
git remote add mirror $MIRRORDIR/$1.git

