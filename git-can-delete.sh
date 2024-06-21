#!/bin/bash
branchToCheck=$1
startingBranch=`git rev-parse --abbrev-ref HEAD`

git checkout --quiet -b tmp-git-can-delete ${branchToCheck}
git merge --quiet ${startingBranch}
branchDiff=`git diff ${startingBranch}`

echo
if [[ -z "${branchDiff}" ]]; then
  echo "'${branchToCheck}' is safe to delete"
else
  echo "'${branchToCheck}' has changes not in '${startingBranch}'"
fi
echo

git checkout --quiet ${startingBranch}
git branch --quiet -D tmp-git-can-delete
