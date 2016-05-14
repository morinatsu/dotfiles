Git
===

```bash
# list Authors
$ git shortlog --summary --email

# remove untracked files from the working tree
$ git clean -d --dry-run
$ git clean -d --force

# search file name in previous commit
$ git log -S <string>
$ git log --pretty=oneline --name-only -S <string>
```
