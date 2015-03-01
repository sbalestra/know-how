# Git cheat sheet

## Diffing

Show diff between working directory and the index (=what could be added with `git add` but hasn't yet been added):

    git diff

Show diff between the index and the most recent commit:

`git diff --staged` = `git diff --cached`

Show diff between working dirctory and the most recent commit:

    git diff HEAD

Show diff between two commits:

    git diff oldhash newhash

Sources:

- http://git-scm.com/docs/git-diff
- http://www.gitguys.com/topics/git-diff/

# Resetting

See http://git-scm.com/blog/2011/07/11/reset.html

## Stashing

See also http://git-scm.com/book/en/v1/Git-Tools-Stashing

##### Stash your work

    git stash

This will result in a clean working directory.

##### See list of stored stashes

    git stash list

Newer entries are on top and have a lower number in `stash@{3}`. Dates of stashes can be seen using:

    git stash list --date=local

(Source: http://stackoverflow.com/q/15551618 )

##### Apply a stash

Get a preview what applying a stash will look like (from http://stackoverflow.com/q/7677736 ):

    git stash show -p stash@{0}

Apply the most recent stash:  

    git stash apply

Apply the most recent stash and re-stage files that were staged when stashing:  

    git stash apply --index

Apply the most recent stash and remove it from the stash stack:

    git stash pop

Apply an older stash:  

    git stash apply stash@{3}

##### Un-apply a stash

    git stash show -p stash@{3} | git apply -R

or shorter for the most recent stash:

    git stash show -p | git apply -R

##### Create a new branch from a stash

    git stash branch mynewbranch

This drops the stash.

##### Remove a stash from the list of stashes

    git stash drop stash@{2}

or shorter for the most recent stash:

    git stash drop

## Squashing

Source: https://ariejan.net/2011/07/05/git-squash-your-latests-commits-into-one/

Assumption: You have some local commits that you want to combine before pushing them to a shared repository. (Don't do this if the commits have already been published!)

Say you want to combine the latest 3 commits, then do:

    git rebase -i HEAD~3

The order is latest at the bottom, in contrast to `git log` where the latest commits are on top.

Change the word `pick` to `squash` on all lines except the first. Save the file and quit your editor.

A new editor window opens. Choose a commit message. Everything without `#` in front will be contained in the commit message.

##### Squash remote commits

If you really must squash remote commits, perform the local steps as described above.

Then force the upload by:

    git push origin +mybranch

If local and remote branches have different names:

    git push origin +localbranch:remotebranch

Sources:

- https://stackoverflow.com/questions/5667884/how-to-squash-commits-in-git-after-they-have-been-pushed
- http://git-scm.com/docs/git-push (see last example at the end of the document: `git push origin +dev:master`)
