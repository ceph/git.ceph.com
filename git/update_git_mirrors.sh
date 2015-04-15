#!/bin/sh

GITDIR=$HOME/git.ceph.com
MIRRORDIR=$HOME/git/mirror

cd $GITDIR
for f in `ls -d *.git`
do
  echo $f
  test -d $f && ( cd $f && git fetch -p origin && git update-server-info )
done


# push to local mirror so that emails get sent
for f in `ls $MIRRORDIR`
do
  cd $GITDIR/$f
  NAME="$f" git push -f --all mirror
  NAME="$f" git push -f --tags mirror
  cd $MIRRORDIR/$f
  git remote set-url origin $GITDIR/$f
  git fetch -p origin
done

