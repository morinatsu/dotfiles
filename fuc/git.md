Git
===

```bash
# http://qiita.com/digdagdag/items/e577611a032abc148664

# list Authors
$ git shortlog --summary --email

# count added and deleted lines
$ git log --numstat --pretty='%H' | awk 'NF==3 {a+=$1; d+=$2} END {printf("+%d, -%d\n", a, d)}'

# count commits
$ git log --oneline --no-merges | wc -l

# ignore newline diff
$ git diff -w

# only list tags which contain the specified commit (HEAD if not specified)
$ git tag --contains=<commit-id>

# show only names and status of changed files
$ git log --name-status

# remove merged branch
# http://gutch.hatenablog.com/entry/2014/05/17/155840
$ git branch --merged | grep -vF '*' | xargs -n1 -t git brnach -d

# add new URL
$ git remote set-url --add <url>

# remove untracked files from the working tree
$ git clean -d --dry-run
$ git clean -d --force

# http://qiita.com/katsew/items/43479230cf863f1c89bf
# list specified type files
$ git diff --name-only --diff-filter=<mark>
# list untracked files
$ git ls-files --others --exclude-standard

# http://qiita.com/phi/items/710222fa806640734adf
# When checking out paths from the index, check out stage #2 (ours) or #3 (theirs) for unmerged paths.
$ git checkout --ours <file>
$ git checkout --theirs <file>

# search file name in previous commit
$ git log -S <string>
$ git log --pretty=oneline --name-only -S <string>

# http://blog.shibayu36.org/entry/2015/08/19/095641
$ git log @{u}..HEAD --format="- %H %s"

# http://qiita.com/kishi_yama/items/20c708a034890c519799
$ git checkout stash@{0} -- <filename>
$ git show stash@{0}:<full/filename>  >  <newfile>

# http://qiita.com/ramuneya/items/5f94c37cc6441a9a7f34
$ git log -S" $" --pickaxe-regex --name-only --pretty="__NEWLINE__%h%x09%an%x09%ae%x09%s" | tr "\n" "\t" | sed 's/__NEWLINE__/\n/g'

# http://motemen.hatenablog.com/entry/2015/10/git-commit-fixup
$ git commit --fixup=HEAD~1
$ git commit --fixup ':/some commit'
$ git rebase -i --autosquash HEAD~3

# http://qiita.com/bibio/items/94983de865e3aaf8be9c
$ git commit --amend --reset-author

# http://qiita.com/usamik26/items/56d0d3ba7a1300625f92
$ git update-index --assume-unchanged <file>
$ git update-index --no-assume-unchanged <file>
$ git update-index --skip-worktree <file>
$ git update-index --no-skip-worktree <file>
```
